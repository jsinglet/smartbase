with Ada.Text_IO;

with Device;
with HAL.GPIO;
with CLI;
with Bed; use Bed;
with Logger; use Logger;
with Ada.Real_time; use Ada.Real_Time;
with RandomInteger;
with System;
with Device; use Device;
with HAL.GPIO; use HAL.GPIO;
with MQTT;
with Util; use Util;
with HAL.LED; use HAL.LED;
with LED; use LED;
with MotionDetector;

procedure Main is

   The_Bed : Bed.Object := (
                         Head_Up_Pin   => Device.Head_Up_Pin,
                         Head_Down_Pin => Device.Head_Down_Pin,
                         Feet_Up_Pin   => Device.Feet_Up_Pin,
                         Feet_Down_Pin => Device.Feet_Down_Pin
                           );
   procedure Init is
   begin
      Device.GPIO.Initialize_Hardware;
      Device.LED.Initialize_Hardware;
      MotionDetector.Initialize_Hardware;
   end Init;

   -- B, G, R

   C1 : Color := (255, 165, 0);
   C2 : Color := (255, 0, 0);
   P : Integer :=0;


begin

--     Device.LED.Pulse(LED_Color      => C1,
--                      Num_Pulses     => 3,
--                      Max_Brightness => 255);
--
--     Device.LED.Solid_On(LED_Color  => C2,
--                         Brightness => 255);
--
--
--     delay until Util.Next_N_Ms(5000);
--
--     Device.LED.All_Off;
--
--     for I in Integer range 1..1000 loop
--        Device.LED.Spinner(Foreground => (0,255,255),
--                           Background => (0,0,255),
--                           Brightness => 255,
--                           Position   => P,
--                           Width      => 3);
--
--        delay until Util.Next_N_Ms(50);
--
--        if P = 0 then
--           delay until Util.Next_N_Ms(50);
--        end if;
--
--
--     end loop;

   Log(SmartBase_Log, "Default Priority for this system: " & System.Default_Priority'Image);

   Log(SmartBase_Log, "Starting");

   Init;

   Log(SmartBase_Log, "Starting Bed");

   The_Bed.Start;

   MQTT.Control.Enable(The_Bed);

   Log(SmartBase_Log, "Starting CLI");
   CLI.Command_Control.Enable(The_Bed);

   loop
      delay until Util.Next_N_Ms(5000);
   end loop;


end Main;



