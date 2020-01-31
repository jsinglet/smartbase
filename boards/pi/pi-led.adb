with Logger; use Logger;
with HAL.LED; use HAL.LED;
with ws2812b_led_h; use ws2812b_led_h;
with Interfaces.C; use Interfaces.C;
with Interfaces; use Interfaces;
with Util; 
package body PI.LED is
   
   procedure Fade_On(This : PI_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) is
      Steps : Brightness_Array(1..Num_Samples);                                 
   begin
      
      Log(PI_LED_Log, "Fading On...");
      
      Steps := Get_Fade_Up_Range(Max_Brightness, Num_Samples);
      
      for I in Steps'Range loop
         -- Log(PI_LED_Log, "Brightness=" & Steps(I)'Image);
         declare 
            
            Brightness : short := short(Steps(I));
            C_Return : int;
            Return_Value : Integer;
         begin
            
            setBrightness(short(Brightness));
            
            for Pixel in Integer range 0..This.Number_Of_LEDs-1 loop
               setPixelColor(0, int(LED_Color.R), int(LED_Color.G), int(LED_Color.B), int(Pixel));
            end loop;
              
            C_Return := show;
            
            Return_Value := Integer(C_Return);
            
            if Return_Value /= 0 then 
               raise LED_Initialization_Error;
            end if;
            
            
            
            
         end;
           


      end loop;
   end Fade_On;

   
   procedure Spinner(This : PI_LED; Foreground : Color; Background : Color; Brightness : Integer; Position : in out Integer; Width : Integer) is 
      C_Return : int;
      Return_Value : Integer;      
   begin

      This.Solid_On(LED_Color  => Background,
                    Brightness => Brightness);
      
      
      for Pixel in Integer range Position..Position+Width loop 
         
         setPixelColor(0, int(Foreground.R), int(Foreground.G), int(Foreground.B), int(Pixel));
         
         C_Return := show;
            
         Return_Value := Integer(C_Return);
            
         if Return_Value /= 0 then 
            raise LED_Initialization_Error;
         end if;          
         
      end loop;
      
      Position := (Position + 1) mod This.Number_Of_LEDs;
      
   end Spinner;
   

   
   
   procedure Fade_Off(This : PI_LED; LED_Color : Color; Max_Brightness : Integer; Num_Samples : Integer := Default_Num_Samples) is
      Steps : Brightness_Array(1..Num_Samples);                                 
   begin 
      Log(PI_LED_Log, "Fade Off...");      
      
      Steps := Get_Fade_Down_Range(Max_Brightness, Num_Samples);
      
      for I in Steps'Range loop
         --Log(PI_LED_Log, "Brightness=" & Steps(I)'Image);
         declare             
            Brightness : short := short(Steps(I));
            C_Return : int;
            Return_Value : Integer;        
         begin
            
            setBrightness(short(Brightness));
            
            for Pixel in Integer range 0..This.Number_Of_LEDs-1 loop               
               setPixelColor(0, int(LED_Color.R), int(LED_Color.G), int(LED_Color.B), int(Pixel));
            end loop;
              
            C_Return := show;
            
            Return_Value := Integer(C_Return);
            
            if Return_Value /= 0 then 
               raise LED_Initialization_Error;
            end if;                      
         end;          
      end loop;
   end Fade_Off;
   
   
   procedure Pulse(This : PI_LED; LED_Color : Color; Num_Pulses: Integer; Pulse_Length : Integer; Max_Brightness : Integer) is
   begin
      Log(PI_LED_Log, "Pulse...");
      
      for I in Integer range 1..Num_Pulses loop 
         
         This.All_Off;

         This.Fade_On(LED_Color      => LED_Color,
                      Max_Brightness => Max_Brightness,
                      Num_Samples => Pulse_Length);
         
         
         This.Fade_Off(LED_Color      => LED_Color,
                       Max_Brightness => Max_Brightness,
                        Num_Samples => Pulse_Length);

      end loop;
      
      
   end Pulse;      
   
   
   procedure Initialize_Hardware(This : PI_LED) is 
      C_Return : int := c_begin(int(This.Number_Of_LEDs), int(This.GPIO_Pin));
      Return_Value : Integer := Integer(C_Return);
   begin
      
      if Return_Value /= 0 then 
         raise LED_Initialization_Error;
      end if;            
   end Initialize_Hardware;
   
   procedure Solid_On(This : PI_LED; LED_Color : Color; Brightness : Integer) is 
      C_Return : int;
      Return_Value : Integer;        
   begin
     
      setBrightness(short(Brightness));
            
      for Pixel in Integer range 0..This.Number_Of_LEDs-1 loop               
         setPixelColor(0, int(LED_Color.R), int(LED_Color.G), int(LED_Color.B), int(Pixel));
      end loop;
              
      C_Return := show;
            
      Return_Value := Integer(C_Return);
            
      if Return_Value /= 0 then 
         raise LED_Initialization_Error;
      end if;                                    
      
   end Solid_On;
   

   procedure All_Off(This : PI_LED) is 
   begin     
      This.Solid_On(LED_Color  => (0,0,0),
                    Brightness => 0);
   end All_Off;
   
   
     
   
   
end PI.LED;
