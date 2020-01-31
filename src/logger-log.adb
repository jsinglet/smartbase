with Logger;
with Ada.Text_IO; use Ada.Text_IO;

separate(Logger)
procedure Log(Category : Logger_Type; Message : String) is
begin
   case Category is
      when SmartBase_Log => Put("[SmartBase]");
      when Bed_Log => Put("[Bed]");
      when Bed_Bed_Control_Log => Put("[Bed.Bed_Control]");
      when Bed_Timer_Task_Log => Put("[Bed.Timer_Task]");
      when Any_GPIO_Log => Put("[Any.GPIO]");
      when PI_GPIO_Log => Put("[PI.GPIO]");
      when MQTT_Log => Put("[MQQT]");
      when Commands_Log => Put("[Commands]");
      when Any_LED_Log => Put("[Any.LED]");
      when PI_LED_Log => Put("[PI.LED]");
      when HAL_LED_Log => Put("[HAL.LED]");
      when LED_Log => Put("[LED]");
      when MotionDetector_Log => Put("[MotionDetector]");
   end case;


   Put_Line(" " & Message);
end Log;


