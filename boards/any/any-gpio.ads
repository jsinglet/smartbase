with HAL.GPIO; use HAL.GPIO;

package Any.GPIO with
  SPARK_Mode => On 
is
   pragma Elaborate_Body;

   type Console_GPIO is new GPIO_Type with null record;
      
   overriding
   procedure Initialize_Hardware(This : Console_GPIO);
   
   overriding
   procedure Pin_Mode(This : Console_GPIO; Pin : Pin_Type; Mode: Mode_Type);
   
   overriding
   procedure Digital_Write(This : Console_GPIO; Pin : Pin_Type; Value : Value_Type);
   
   overriding   
   function Digital_Read(This : Console_GPIO; Pin : Pin_Type;  Default_Value: in Value_Type := Floating) return Value_Type;
   
end Any.GPIO;
