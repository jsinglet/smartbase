with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body HAL.LED is

  function Compute_Steps(Num_Samples : Integer) return Brightness_Number is
   begin
      return (Max_Radians - Shifted_Zero)/Brightness_Number(Num_Samples);
   end Compute_Steps;
   
      

   
   function Get_Fade_Up_Range(Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) return Brightness_Array is
      Step : Brightness_Number := Compute_Steps(Num_Samples);
      Max_Brightness_Value : constant Brightness_Number := Brightness_Number(Max_Brightness);
      Steps : Brightness_Array(1..Num_Samples);
      Current_Step : Brightness_Number := Shifted_Zero; -- start at zero
   begin
      

      for I in Steps'Range loop
         
         declare
            Current_Brightness : Brightness_Number;            
         begin            
            Current_Brightness := Brightness_Number(Sin(Float(Current_Step))) * (Max_Brightness_Value/2) + (Max_Brightness_Value/2);
      
            Steps(I) := Integer(Brightness_Number'Round(Current_Brightness));

            Current_Step := Current_Step + Step;
         end;
         
         
      end loop;
      
      return Steps;   
   end Get_Fade_Up_Range;
   
   
   function Get_Fade_Down_Range(Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) return Brightness_Array is
      Step : Brightness_Number := Compute_Steps(Num_Samples);
      Max_Brightness_Value : constant Brightness_Number := Brightness_Number(Max_Brightness);
      Steps : Brightness_Array(1..Num_Samples);
      Current_Step : Brightness_Number := Max_Radians; -- start at the maximum 
   begin
      

      for I in Steps'Range loop
         
         declare
            Current_Brightness : Brightness_Number;            
         begin            
            Current_Brightness := Brightness_Number(Sin(Float(Current_Step))) * (Max_Brightness_Value/2) + (Max_Brightness_Value/2);
      
            Steps(I) := Integer(Brightness_Number'Round(Current_Brightness));

            Current_Step := Current_Step - Step;
         end;
         
         
      end loop;
      
      return Steps;   
   end Get_Fade_Down_Range;
   

end HAL.LED;
