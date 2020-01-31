pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package smartbase_mqtt_client_h is

   MESSAGE_BUFFER_TOO_SHORT : constant := -10;  --  smartbase_mqtt_client.h:2
   CLIENT_DISCONNECTED : constant := -3;  --  smartbase_mqtt_client.h:3

   function mqtt_client_wait_for_message
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : int;
      arg3 : unsigned_long) return int;  -- smartbase_mqtt_client.h:5
   pragma Import (C, mqtt_client_wait_for_message, "mqtt_client_wait_for_message");

   function mqtt_client_connect
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : Interfaces.C.Strings.chars_ptr) return int;  -- smartbase_mqtt_client.h:6
   pragma Import (C, mqtt_client_connect, "mqtt_client_connect");

    function mqtt_client_connect_cert
     (address : Interfaces.C.Strings.chars_ptr;
      client_id : Interfaces.C.Strings.chars_ptr;
      topic : Interfaces.C.Strings.chars_ptr;
      cafile : Interfaces.C.Strings.chars_ptr;
      key : Interfaces.C.Strings.chars_ptr;
      cert : Interfaces.C.Strings.chars_ptr      
      ) return int;  
   pragma Import (C, mqtt_client_connect_cert, "mqtt_client_connect_cert");

end smartbase_mqtt_client_h;
