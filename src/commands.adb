with Ada.Real_time; use Ada.Real_Time;
with Logger; use Logger;
with System_Test; use System_Test;
with Ada.Exceptions;  use Ada.Exceptions;
with Bed; use Bed;
with LED; use LED;
with Util; 
package body Commands is

   procedure Handle_Command(B : Bed.Object; Command : String) is 
      Current_Command : Command_Type;
   begin
      
      Current_Command := Command_Type'Value(Command);
      case Current_Command is                         
         when HeadUp =>                  
            B.Move(
                   Unit => Head,
                   Travel_Direction => Up,
                   Duration => 10000
                  );
         when HeadDown =>
            B.Move(
                   Unit => Head,
                   Travel_Direction => Down,
                   Duration => 10000
                  );
         when FeetUp =>
            B.Move(
                   Unit => Foot,
                   Travel_Direction => Up,
                   Duration => 10000
                  );

         when FeetDown =>
            B.Move(
                   Unit => Foot,
                   Travel_Direction => Down,
                   Duration => 10000
                  );
         when TestUnits =>
            Test_Units(B);
            
         when FadeOn =>
            LED.LED_Status_Manager.Set_Status(FADE_ON);
         when FadeOff => 
            LED.LED_Status_Manager.Set_Status(FADE_OFF);
         when Connecting =>
            LED.LED_Status_Manager.Set_Status(CONNECTING);
            -- allow it to run for 5 seconds
            delay until Util.Next_N_Ms(5000);
            LED.LED_Status_Manager.Set_Status(OFF);
         when Connected => 
            LED.LED_Status_Manager.Set_Status(CONNECTED);
      end case;                  
                                     
   exception
      when Constraint_Error => Log(Commands_Log, "Invalid Command.");
   end Handle_Command;


end Commands;
