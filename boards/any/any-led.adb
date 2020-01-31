with Logger; use Logger;
with HAL.LED; use HAL.LED;

package body Any.LED is


   procedure Fade_On(This : Any_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) is
      Steps : Brightness_Array(1..Num_Samples);                                 
   begin
      Log(Any_LED_Log, "Fading On...");
      
      Steps := Get_Fade_Up_Range(Max_Brightness);
      
      for I in Steps'Range loop
         Log(Any_LED_Log, "Brightness=" & Steps(I)'Image);
      end loop;
      
   end Fade_On;
   
   
   procedure Fade_Off(This : Any_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) is
      Steps : Brightness_Array(1..Num_Samples);                                 
   begin 
      Log(Any_LED_Log, "Fade Off...");      
      
      Steps := Get_Fade_Down_Range(Max_Brightness);
      
      for I in Steps'Range loop
         Log(Any_LED_Log, "Brightness=" & Steps(I)'Image);
      end loop;
      
   end Fade_Off;
   
   
   procedure Pulse(This : Any_LED; LED_Color : Color; Num_Pulses: Integer; Max_Brightness : Integer) is
   begin
      Log(Any_LED_Log, "Pulse...");
   end Pulse;
   

end Any.LED;
