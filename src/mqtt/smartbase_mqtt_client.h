
#define MESSAGE_BUFFER_TOO_SHORT -10
#define CLIENT_DISCONNECTED -3

int mqtt_client_wait_for_message(char* buffer, int maxLength, unsigned long int timeout);
int mqtt_client_connect(const char *ADDRESS, const char *CLIENTID, const char *TOPIC, const char *username, const char *password);
int mqtt_client_connect_cert(
  const char *ADDRESS /* for aws, ssl://host:8883 */, 
  const char *CLIENTID, 
  const char *TOPIC, 
  const char *cafile  /* the root ca */, 
  const char *key /* the private key */, 
  const char *cert    /* the certificate */ );