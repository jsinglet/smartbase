package HAL.GPIO is
   
   type GPIO_Type is interface;
   
   subtype Pin_Type is Integer;
   
   type ISR_Callback_Function is access procedure;
   
   Pin_None : constant Pin_Type := -1;
   
   type Mode_Type is (
                      Input,
                      Output
                     );
   
   type Value_Type is (
                       Low, 
                       High,
                       Floating
                      );
   

   for Mode_Type use (
                      Input => 0,
                      Output => 1
                      
                     );
   
   for Value_Type use (
                       Low => 0,
                       High => 1,
                       Floating => 2
                      );
   
   type Edge_Type is (
                      SETUP,
                      FALLING,
                      RISING,
                      BOTH
                     );
   
   for Edge_Type use (
                      SETUP => 0,
                      FALLING => 1,
                      RISING => 2,
                      BOTH => 3
                     );
                         
      
   type Pin_Array is array (Natural range <>) of Pin_Type;
   
   procedure Initialize_Hardware(This : GPIO_Type) is abstract;
   procedure Pin_Mode(This : GPIO_Type; Pin : Pin_Type; Mode: Mode_Type) is abstract;
   procedure Digital_Write(This : GPIO_Type; Pin : Pin_Type; Value : Value_Type) is abstract;
   function Digital_Read(This : GPIO_Type; Pin : Pin_Type; Default_Value: in Value_Type := Floating) return Value_Type is abstract;    
   procedure Register_ISR_1(This : GPIO_Type; Pins : Pin_Array; Mode : Edge_Type; Callback : ISR_Callback_Function) is abstract;
   
end HAL.GPIO;
