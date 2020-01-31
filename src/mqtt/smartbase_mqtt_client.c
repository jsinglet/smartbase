#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "MQTTClient.h"
#include "smartbase_mqtt_client.h"

#define QOS         1


MQTTClient client;
MQTTClient_connectOptions conn_opts = MQTTClient_connectOptions_initializer;
MQTTClient_SSLOptions ssl_opts = MQTTClient_SSLOptions_initializer;

int MQTT_CLIENT_CONNECTED = 0;

/**
 * Returns the length of the message. If the length is negative, it's an error code that has to be 
 * inspected.
 **/
int mqtt_client_wait_for_message(char* buffer, int maxLength, unsigned long int timeout)
{

  void *context;
  char *topicName;
  int topicLen;
  int payloadLength;

  MQTTClient_message *message;
  int rc = MQTTClient_receive(client, &topicName, &topicLen, &message, timeout);

  if(!(rc==MQTTCLIENT_SUCCESS || rc==MQTTCLIENT_TOPICNAME_TRUNCATED))
  {    
    return rc;
  }

  if (message == NULL)
  {
    MQTTClient_free(topicName);

    return 0;
  }

  int i;
  char *payloadptr;

  payloadptr = message->payload;

  if(message->payloadlen >= maxLength){
    
    MQTTClient_freeMessage(&message);
    MQTTClient_free(topicName);

    return MESSAGE_BUFFER_TOO_SHORT;
  }

  for (i = 0; i < message->payloadlen; i++)
  {
    buffer[i] = *payloadptr++;
  }

  //buffer[i] = '\0';

  payloadLength = message->payloadlen;

  MQTTClient_freeMessage(&message);
  MQTTClient_free(topicName);

  return payloadLength;
}

int mqtt_client_connect(const char *ADDRESS, const char *CLIENTID, const char *TOPIC, const char *username, const char *password)
{
  int rc;
  int ch;

  MQTTClient_create(&client, ADDRESS, CLIENTID,
                    MQTTCLIENT_PERSISTENCE_NONE, NULL);
  conn_opts.keepAliveInterval = 20;
  conn_opts.cleansession = 1;  
  conn_opts.username = username;
  conn_opts.password = password;

  if ((rc = MQTTClient_connect(client, &conn_opts)) != MQTTCLIENT_SUCCESS)
  {
    return rc;
  }

  MQTTClient_subscribe(client, TOPIC, QOS);

  return 0;
}

int mqtt_client_connect_cert(
  const char *ADDRESS /* for aws, ssl://host:8883 */, 
  const char *CLIENTID, 
  const char *TOPIC, 
  const char *cafile  /* the root ca */, 
  const char *key /* the private key */, 
  const char *cert    /* the certificate */ ){

  int rc;
  int ch;

  MQTTClient_create(&client, ADDRESS, CLIENTID,
                    MQTTCLIENT_PERSISTENCE_NONE, NULL);
  conn_opts.keepAliveInterval = 20;
  conn_opts.cleansession = 1;  

  // set ssl options 
  ssl_opts.keyStore = cert;
  ssl_opts.trustStore = cafile;
  ssl_opts.privateKey = key;
  conn_opts.ssl = &ssl_opts;

  
  if ((rc = MQTTClient_connect(client, &conn_opts)) != MQTTCLIENT_SUCCESS)
  {
    return rc;
  }

  MQTTClient_subscribe(client, TOPIC, QOS);

  return 0;


}
