with NRF52_SVD.Device; use NRF52_SVD.Device;
with Logger; use Logger;

package body Argon.GPIO is
   
   function Translate_Pin(Pin : Pin_Type) return Pin_Type is
   begin
      if Pin >= P1_Offset then 
         return Pin - P1_Offset;
      end if;
        
      return Pin;
   end Translate_Pin;
   
   function Get_Peripheral_For_Pin(Pin : Pin_Type) return Peripheral_Ptr is
   begin
      
      if Is_P0(Pin) then 
         return P0_Periph'Access;         
      end if;
      
      return P1_Periph'Access;      
   end Get_Peripheral_For_Pin;
     
   
   
   procedure Initialize_Hardware(This : Argon_GPIO) is 
   begin   
      Log(PI_GPIO_Log, "Initializing Hardware....");      
   end Initialize_Hardware;
      
   procedure Pin_Mode(This : Argon_GPIO; Pin : Pin_Type; Mode: Mode_Type) is
      GPIO_Peripheral : Peripheral_Ptr := Get_Peripheral_For_Pin(Pin);
      Peripheral_Pin : Pin_Type := Translate_Pin(Pin);
      CNF : PIN_CNF_Register renames GPIO_Peripheral.PIN_CNF (Peripheral_Pin);
   begin   
      
      Log(PI_GPIO_Log, "Setting Pin=" & Peripheral_Pin'Image & " to Mode=" & Mode'Image); 
      
      
      if mode = Output then 
         CNF.DIR   := Output;
         CNF.INPUT := Disconnect;
         CNF.PULL  := Pulldown;
         CNF.DRIVE := S0S1;
         CNF.SENSE := Disabled;
      end if;
      
   end Pin_Mode;
   
   
   procedure Digital_Write(This : Argon_GPIO; Pin : Pin_Type; Value : Value_Type) is
      Peripheral_Pin : Pin_Type := Translate_Pin(Pin);      
   begin
      -- for logging, use the resolved pin but pass
      -- the unresolved pin through.
      Log(PI_GPIO_Log, "Digital Write to Pin=" & Peripheral_Pin'Image & " with Value=" & Value'Image);
      
      if Value = High then 
         Set(Pin);
      else 
         Clear(Pin);
      end if;
      
      
   end Digital_Write;
   
   function Digital_Read(This : Argon_GPIO; Pin : Pin_Type;  Default_Value: in Value_Type := Floating) return Value_Type is
      Read_Value : Value_Type;      
   begin 
      
      if Default_Value = Floating then 
         Read_Value := Default_Value;
      else
         Read_Value := High; 
      end if;
      
      Log(PI_GPIO_Log, "Digital Read from Pin=" & Pin'Image & " returning Value=" & Read_Value'Image);

      return Read_Value;
   end Digital_Read;
   
   
   -----------------------------------
   -- Board Specific Implementation --
   -----------------------------------
   


   function Is_P0(Pin : Pin_Type) return Boolean is
   begin       
      if Translate_Pin(Pin) = Pin then 
         return True;
      end if;
      
      return False;
   end Is_P0;
   
      
   procedure Clear (Pin : Pin_Type) is
      GPIO_Peripheral : Peripheral_Ptr := Get_Peripheral_For_Pin(Pin);
      Peripheral_Pin : Pin_Type := Translate_Pin(Pin);
   begin      
      GPIO_Peripheral.OUT_k.Arr (Peripheral_Pin) := Low;      
   end Clear;

   
   procedure Set (Pin : Pin_Type) is
      GPIO_Peripheral : Peripheral_Ptr := Get_Peripheral_For_Pin(Pin);
      Peripheral_Pin : Pin_Type := Translate_Pin(Pin);
   begin
      GPIO_Peripheral.OUT_k.Arr (Peripheral_Pin) := High;
   end Set;

   procedure Configure_GPIO (Pin : Pin_Type) is
      GPIO_Peripheral : Peripheral_Ptr := Get_Peripheral_For_Pin(Pin);
      Peripheral_Pin : Pin_Type := Translate_Pin(Pin);
      CNF : PIN_CNF_Register renames GPIO_Peripheral.PIN_CNF (Peripheral_Pin);
   begin
      
      CNF.DIR   := Output;
      CNF.INPUT := Disconnect;
      CNF.PULL  := Pulldown;
      CNF.DRIVE := S0S1;
      CNF.SENSE := Disabled;
           
   end Configure_GPIO;

   
   
   
end Argon.GPIO;
