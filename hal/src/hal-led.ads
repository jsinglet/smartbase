with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with HAL.GPIO; use HAL.GPIO;

package HAL.LED is

   type Brightness_Array is array (Natural range <>) of Integer;
   type Brightness_Number is delta 0.0000001 digits 12;
   
   LED_Initialization_Error : exception;
   
   type Color is record 
      R : Integer range 0..255;
      G : Integer range 0..255;
      B : Integer range 0..255;
   end record;
   
   
   type LED_Type is tagged record 
      GPIO_Pin : Pin_Type;   
      Number_Of_LEDs : Integer;
   end record;
   
   -- Constants
   Max_Radians  : constant Brightness_Number := Ada.Numerics.Pi * 2.5;  -- end where the function is maximized on the right of the zero
   Shifted_Zero : constant Brightness_Number  := Ada.Numerics.Pi * 1.5; -- This is where we find our first zero
   Default_Num_Samples  : constant Integer  := 300; 
   
   function Compute_Steps(Num_Samples : Integer) return Brightness_Number;

   -- Functions we expect to be implemented by a specific board 
   function Get_Fade_Up_Range(Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) return Brightness_Array;
   function Get_Fade_Down_Range(Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) return Brightness_Array;
   
   procedure Initialize_Hardware(This : LED_Type) is null;
   procedure Fade_On(This : LED_Type; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) is null;
   procedure Fade_Off(This : LED_Type; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) is null;
   procedure Pulse(This : LED_Type; LED_Color : Color; Num_Pulses: Integer; Pulse_Length: Integer; Max_Brightness : Integer) is null;
   procedure Solid_On(This : LED_Type; LED_Color : Color; Brightness : Integer) is null;
   procedure Spinner(This : LED_Type; Foreground : Color; Background : Color; Brightness : Integer; Position : in out Integer; Width : Integer) is null;
   procedure All_Off(This : LED_Type) is null;
   
end HAL.LED;
