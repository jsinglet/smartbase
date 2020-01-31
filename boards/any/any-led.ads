with HAL.LED; use HAL.LED;

package Any.LED is

   type Any_LED is new LED_Type with null record;

   overriding
   procedure Fade_On(This : Any_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples);
   
   overriding
   procedure Fade_Off(This : Any_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples);
   
   overriding
   procedure Pulse(This : Any_LED; LED_Color : Color; Num_Pulses: Integer; Max_Brightness : Integer);
   
   
end Any.LED;
