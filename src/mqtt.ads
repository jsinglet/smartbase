with Bed; use Bed;

package MQTT is

   task MQTT_Client with Priority => 5;



   protected Control is
      procedure Enable(The_Bed : Bed.Object);
      procedure Disable;

      function Get_Bed return Bed.Object;
      entry Enabled;
   private
      Enable_MQTT : Boolean := False;
      The_Bed : Bed.Object;
   end Control;
end MQTT;
