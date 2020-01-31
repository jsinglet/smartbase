with HAL.GPIO; use HAL.GPIO;
with NRF52_SVD.GPIO; use NRF52_SVD.GPIO;

package Argon.GPIO is
   

   type Argon_GPIO is new GPIO_Type with null record;
      
   overriding
   procedure Initialize_Hardware(This : Argon_GPIO );
   
   overriding
   procedure Pin_Mode(This : Argon_GPIO; Pin : Pin_Type; Mode: Mode_Type);
   
   overriding
   procedure Digital_Write(This : Argon_GPIO; Pin : Pin_Type; Value : Value_Type);
   
   overriding   
   function Digital_Read(This : Argon_GPIO; Pin : Pin_Type;  Default_Value: in Value_Type := Floating) return Value_Type;

  
   Unknown_Pin_Configuration : exception;

private 
   type Peripheral_Ptr is access all GPIO_Peripheral;
   
   function Get_Peripheral_For_Pin(Pin : Pin_Type) return Peripheral_Ptr;
 
   function Is_P0(Pin : Pin_Type) return Boolean;
   
                 
   
   procedure Clear (Pin : Pin_Type);
  
   procedure Set (Pin : Pin_Type);
  
   procedure Configure_GPIO (Pin : Pin_Type);
   
   
end Argon.GPIO;
