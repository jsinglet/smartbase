with HAL.LED; use HAL.LED;

package PI.LED is
   
   type PI_LED is new LED_Type with null record;

   overriding
   procedure Fade_On(This : PI_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples);
   
   overriding
   procedure Fade_Off(This : PI_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples);
   
   overriding
   procedure Pulse(This : PI_LED; LED_Color : Color; Num_Pulses: Integer; Pulse_Length : Integer; Max_Brightness : Integer);   

   overriding
   procedure Initialize_Hardware(This : PI_LED);
   
   overriding
   procedure Solid_On(This : PI_LED; LED_Color : Color; Brightness : Integer);

   overriding
   procedure All_Off(This : PI_LED);

   overriding
   procedure Spinner(This : PI_LED; Foreground : Color; Background : Color; Brightness: Integer; Position : in out Integer; Width : Integer);


end PI.LED;
