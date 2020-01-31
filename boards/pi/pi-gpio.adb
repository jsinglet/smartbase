with Logger; use Logger;
with isr_h;

package body PI.GPIO is

   
   procedure Initialize_Hardware(This : PI_GPIO) is 
      Setup_Result : Integer;
   begin   
      Log(PI_GPIO_Log, "Initializing Hardware....");      
      -- Note: Per wiringPi, the return value of this is always 1
      -- If it fails the program exists. 
      Setup_Result := WPi_Setup;
   end Initialize_Hardware;
      
   procedure Pin_Mode(This : PI_GPIO; Pin : Pin_Type; Mode: Mode_Type) is 
      Real_Pin : Pin_Type := PI_Pin_To_WPi_Pin(Pin);
   begin   
      Log(PI_GPIO_Log, "Setting Pin=" & Pin'Image & " to Mode=" & Mode'Image); 
      WPI_Pin_Mode(Real_Pin, Mode);
   end Pin_Mode;
   
   
   procedure Register_ISR_1(This : PI_GPIO; Pins : Pin_Array; Mode: Edge_Type; Callback : ISR_Callback_Function) is
      Int_Mode : int := int(Edge_Type'Enum_Rep(Mode));
      Real_Pin : Pin_Type;
   begin
      ISR_1 := Callback;
      
      for I in Pins'Range loop
         Log(PI_GPIO_Log, "Registering ISR1 -> Pin=" & Pins(I)'Image & " Mode=" & Int_Mode'Image);
         Real_Pin := PI_Pin_To_WPi_Pin(Pins(I));
         isr_h.register_isr_1(int(Real_Pin), Int_Mode);
      end loop;
      
   end Register_ISR_1;

   procedure Call_ISR1 is
   begin
      Log(PI_GPIO_Log, "Calling ISR_1");
      if ISR_1 /= null then 
         ISR_1.all;
         Log(PI_GPIO_Log, "Finished calling ISR_1");
      end if;
   end Call_ISR1;
   
   procedure Digital_Write(This : PI_GPIO; Pin : Pin_Type; Value : Value_Type) is
      Real_Pin : Pin_Type := PI_Pin_To_WPi_Pin(Pin);
   begin
      Log(PI_GPIO_Log, "Digital Write to Pin=" & Pin'Image & " with Value=" & Value'Image);
      WPi_Digital_Write(Real_Pin, Value);
   end Digital_Write;
   
   function Digital_Read(This : PI_GPIO; Pin : Pin_Type;  Default_Value: in Value_Type := Floating) return Value_Type is
      Real_Pin : Pin_Type := PI_Pin_To_WPi_Pin(Pin);
      Read_Value : Value_Type;      
   begin 
      
      if Default_Value = Floating then 
         Read_Value := Default_Value;
      else
         Read_Value := WPi_Digital_Read(Real_Pin);
      end if;
      
      Log(PI_GPIO_Log, "Digital Read from Pin=" & Pin'Image & " returning Value=" & Read_Value'Image);

      return Read_Value;
   end Digital_Read;
   
   function PI_Pin_To_WPi_Pin(Pin : Pin_Type) return Pin_Type is
      Real_Pin : Pin_Type;
   begin      
      
      
      
      case Pin is
         when 1 => raise Unknown_Pin_Configuration;
         when 3 => Real_Pin := 8;
         when 5 => Real_Pin := 9;
         when 7 => Real_Pin := 7;
         when 9 => raise Unknown_Pin_Configuration;
         when 11 => Real_Pin := 0;
         when 13 => Real_Pin := 2;
         when 15 => Real_Pin := 3;
         when 17 => raise Unknown_Pin_Configuration;
         when 19 => Real_Pin := 12;
         when 21 => Real_Pin := 13;
         when 23 => Real_Pin := 14;
         when 25 => raise Unknown_Pin_Configuration;
         when 27 => Real_Pin := 30;
         when 29 => Real_Pin := 21;
         when 31 => Real_Pin := 22;
         when 33 => Real_Pin := 23;
         when 35 => Real_Pin := 24;
         when 37 => Real_Pin := 25;
         when 39 => raise Unknown_Pin_Configuration;

         when 2 => raise Unknown_Pin_Configuration;
         when 4 => raise Unknown_Pin_Configuration;
         when 6 => raise Unknown_Pin_Configuration;
         when 8 => Real_Pin := 15;
         when 10 => Real_Pin := 16;
         when 12 => Real_Pin := 1;
         when 14 => raise Unknown_Pin_Configuration;
         when 16 => Real_Pin := 4;
         when 18 => Real_Pin := 5;
         when 20 => raise Unknown_Pin_Configuration;
         when 22 => Real_Pin := 6;
         when 24 => Real_Pin := 10;
         when 26 => Real_Pin := 11;
         when 28 => Real_Pin := 31;
         when 30 => raise Unknown_Pin_Configuration;
         when 32 => Real_Pin := 26;
         when 34 => raise Unknown_Pin_Configuration;
         when 36 => Real_Pin := 27;
         when 38 => Real_Pin := 28;
         when 40 => Real_Pin := 29;

         when others => raise Unknown_Pin_Configuration;
      end case;
      
      Log(PI_GPIO_Log, "Translating Pin=" & Pin'Image & " to WiPi Pin=" & Real_Pin'Image);
      
      return Real_Pin;
            
   end PI_Pin_To_WPi_Pin;
   
end PI.GPIO;
