with Device;
with HAL.GPIO;
with Bed; use Bed;
with Ada.Real_time; use Ada.Real_Time;
with RandomInteger;
with CLI;
package body Master is

   
   function Next_N_Ms(MS : Integer) return Time is
   begin
      return Ada.Real_Time.Clock + Milliseconds(MS);
   end Next_N_Ms;
   
   task body Master_Task is
      The_Bed : Bed.Object := (
                         Head_Up_Pin   => Device.Head_Up_Pin,
                         Head_Down_Pin => Device.Head_Down_Pin,
                         Feet_Up_Pin   => Device.Feet_Up_Pin,
                         Feet_Down_Pin => Device.Feet_Down_Pin
                           );
   begin
      
      The_Bed.Start;

      
      loop
         
         CLI.Test_Units(The_Bed);
      
         delay until Next_N_Ms(15000);   
         
      end loop;
      
      
      
      
   end Master_Task;
   

end Master;
