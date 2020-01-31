with Logger; use Logger;
with smartbase_mqtt_client_h; use smartbase_mqtt_client_h;
with Ada.Exceptions;  use Ada.Exceptions;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C; use Interfaces.C;
with LED; use LED;
with Commands;
with Util; use Util;

package body MQTT is
   
   function Value_Without_Exception(S : chars_ptr; Length : int) return String is
   begin
      if S = Null_Ptr then return "";
      else return Value(S, size_t(Length));
      end if;
   end Value_Without_Exception;
   pragma Inline(Value_Without_Exception);
   
   function Connect_OK(Status : int) return Boolean is
   begin
      if Status = 0 then
         return True;
      end if;
      return False;
   end Connect_OK;
   
   task body MQTT_Client is
      
      -- configuration parameters
      HOST : chars_ptr := New_String("ssl://a3iojuaybb752l-ats.iot.us-east-1.amazonaws.com:8883");      
      CLIENT_ID : chars_ptr := New_String("smartbase");
      FEED : chars_ptr := New_String("smartbase/zero");
      --FEED : chars_ptr := New_String("$aws/things/SmartBase/shadow/update/accepted");
      
      -- ssl features
      CA_FILE : chars_ptr := New_String("certs/AmazonRootCA1.pem");
      KEY_FILE : chars_ptr := New_String("certs/08df2bb8a9-private.pem.key");
      CERT     : chars_ptr := New_String("certs/08df2bb8a9-certificate.pem.crt");
      
      MESSAGE : chars_ptr;
      
      MAX_BUFFER_LENGTH : int  := 50;
      pragma Warnings (Off, "variable ""EMPTY_BUFFER"" is read but never assigned"); -- this is assigned in the C routine.
      EMPTY_BUFFER : String(1..Integer(MAX_BUFFER_LENGTH));
      BUFFER : chars_ptr := New_String(EMPTY_BUFFER);            
      
      MAX_WAIT : unsigned_long := 1000;

      -- interaction values
      Connect_Result : int;      
      Message_Result_Length : int;
      Client_Connected : Boolean := False;
      Counter : Integer :=0;
      Last_Document_Version : Long_Integer:= -1;
   begin 
      LED_Status_Manager.Set_Status(CONNECTING);
      loop         
         
         begin 
            Control.Enabled;    

            if Client_Connected /= True then 
               LED_Status_Manager.Set_Status(CONNECTING);
               Log(MQTT_Log, "Not Connected. Reconnecting.");
            
               Connect_Result := mqtt_client_connect_cert(address   => HOST,
                                                          client_id => CLIENT_ID,
                                                          topic     => FEED,
                                                          cafile    => CA_FILE,
                                                          key       => KEY_FILE,
                                                          cert      => CERT);
               
               Client_Connected := Connect_OK(Connect_Result);
               delay until Next_N_Ms(3000); 
               if Client_Connected then 
                  LED_Status_Manager.Set_Status(CONNECTED);
               end if;
            else 
               -- get a message
               Message_Result_Length :=  mqtt_client_wait_for_message(BUFFER, MAX_BUFFER_LENGTH, MAX_WAIT);
            
               if Message_Result_Length = MESSAGE_BUFFER_TOO_SHORT then
                  Log(MQTT_Log, "Warning: Topic got more data than expected (" & MAX_BUFFER_LENGTH'Image & ")");
               elsif Message_Result_Length = 0 then 
                  Counter := Counter + 1;
                  
                  if Counter = 10 then 
                     Log(MQTT_Log, "No Message for last 10 attempts...");
                     Counter := 0;
                  end if;
                 
               elsif Message_Result_Length = CLIENT_DISCONNECTED then
                  Log(MQTT_Log, "Client Disconected. Will reconnect.");
                  Client_Connected := False;
                  
                  Counter := 0;
               elsif Message_Result_Length < 0 then 
                  Log(MQTT_Log, "Unknown error getting message: " & Message_Result_Length'Image);
                  
                  Counter := 0;
               else 
                  Log(MQTT_Log, "Got Message"); 
                  Log(MQTT_Log, Value_Without_Exception(BUFFER, Message_Result_Length));
                  
                  --Handle_JSON_Payload(Value_Without_Exception(BUFFER, Message_Result_Length), Last_Document_Version);
                  Commands.Handle_Command(B       => Control.Get_Bed,
                                          Command =>  Value_Without_Exception(BUFFER, Message_Result_Length));
                  
                  Counter := 0;
               end if;
              
               delay until Next_N_Ms(1000);                  
            end if;
         exception
            when Error: others => Log(MQTT_Log, "Unhandled Exception in MQTT Loop: " & Exception_Information(Error));
         end;           
      end loop;
      
   end MQTT_Client;
   
   
   protected body Control is 
      procedure Enable(The_Bed : Bed.Object) is
      begin
         Control.The_Bed := The_Bed;
         Enable_MQTT := True;
      
      end Enable;
      
      function Get_Bed return Bed.Object is
      begin
         return The_Bed;
      end Get_Bed;
      
      procedure Disable is 
      begin
         Enable_MQTT := False;
      end Disable;
      
      entry Enabled 
        when Enable_MQTT is
      begin         
         null;
      end Enabled;                  
   end Control;


end MQTT;
