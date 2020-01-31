with Logger; use Logger;

package body Any.GPIO with
  SPARK_Mode => On 
is

   
   procedure Initialize_Hardware(This : Console_GPIO) is 
   begin   
      Log(Any_GPIO_Log, "Initializing Hardware....");      
   end Initialize_Hardware;
      
   procedure Pin_Mode(This : Console_GPIO; Pin : Pin_Type; Mode: Mode_Type) is 
   begin   
      Log(Any_GPIO_Log, "Setting Pin=" & Pin'Image & " to Mode=" & Mode'Image);      
   end Pin_Mode;
   
   
   procedure Digital_Write(This : Console_GPIO; Pin : Pin_Type; Value : Value_Type) is
   begin
      Log(Any_GPIO_Log, "Digital Write to Pin=" & Pin'Image & " with Value=" & Value'Image);
   end Digital_Write;
   
   
   function Digital_Read(This : Console_GPIO; Pin : Pin_Type;  Default_Value: in Value_Type := Floating) return Value_Type is
   begin 
      Log(Any_GPIO_Log, "Digital Read from Pin=" & Pin'Image & " returning Value=" & Default_Value'Image);
      return Default_Value;
   end Digital_Read;
   


end Any.GPIO;
