with Logger; use Logger;
with GNATCOLL.JSON; use GNATCOLL.JSON;

with Commands; use Commands;

package body MQTT.JSON is

      procedure Handle_JSON_Payload(Payload : String; Last_Document_Version : in out Long_Integer) is 
      MQTT_Message : JSON_Value := Read (Payload);  
      This_Document_Version : Long_Integer;
   begin
      
      -- Commands look like this:
      -- To execute this state, we look through the desired 
      -- states and for the first one that is set to "on" we execute it.
      
      --  { "state" : {
      --    "desired" : {
      --      "headup" : "off",
      --      "headdown" : "off",
      --      "feetup"   : "off", 
      --      "feetdown" : "off"
      --    }
      --  }
      
      This_Document_Version := MQTT_Message.Get("version");
      
      Log(MQTT_Log, "Document Version: " & This_Document_Version'Image);
      Log(MQTT_Log, "Previous Document Version: " & Last_Document_Version'Image);
      
      -- it would be a good idea to assume this is monotonic but I 
      -- don't control that so let's just play it safe...
      if This_Document_Version /= Last_Document_Version then 
         
         if MQTT_Message.Get("state").Get("desired").Get(Command_HeadUp) = Command_On then 
            Handle_Command(Control.Get_Bed, Command_HeadUp);
         elsif MQTT_Message.Get("state").Get("desired").Get(Command_HeadDown) = Command_On then 
            Handle_Command(Control.Get_Bed, Command_HeadDown);
         elsif MQTT_Message.Get("state").Get("desired").Get(Command_FeetUp) = Command_On then 
            Handle_Command(Control.Get_Bed, Command_FeetUp);
         elsif MQTT_Message.Get("state").Get("desired").Get(Command_FeetDown) = Command_On then 
            Handle_Command(Control.Get_Bed, Command_FeetDown);
         else
            Log(MQTT_Log, "Ignoring unknown command payload.");
         end if;
                         
         Last_Document_Version := This_Document_Version;
      end if;
   end Handle_JSON_Payload;
   

end MQTT.JSON;
