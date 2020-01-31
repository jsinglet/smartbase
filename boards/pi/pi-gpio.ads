with HAL.GPIO; use HAL.GPIO;
with Interfaces.C; use Interfaces.C;

package PI.GPIO is
   

   type PI_GPIO is new GPIO_Type with null record;
   

   
   overriding
   procedure Initialize_Hardware(This : PI_GPIO);
   
   overriding
   procedure Pin_Mode(This : PI_GPIO; Pin : Pin_Type; Mode: Mode_Type);
   
   overriding
   procedure Digital_Write(This : PI_GPIO; Pin : Pin_Type; Value : Value_Type);
   
   overriding   
   function Digital_Read(This : PI_GPIO; Pin : Pin_Type;  Default_Value: in Value_Type := Floating) return Value_Type;

   overriding
   procedure Register_ISR_1(This : PI_GPIO; Pins : Pin_Array; Mode: Edge_Type; Callback : ISR_Callback_Function);
                              
   function PI_Pin_To_WPi_Pin(Pin : Pin_Type) return Pin_Type;
   
   
   Unknown_Pin_Configuration : exception;
   
private 
   
   ISR_1 : ISR_Callback_Function;
   
   procedure Call_ISR1 
     with
       Export => True,
       Convention => C,
       External_Name => "smartbase_call_isr_1";
   
   
   
   function WPi_Setup return Integer
        with
        Import,
        Convention => C,
        External_Name => "wiringPiSetup";

    function WPi_Setup_Gpio return Integer
        with
        Import,
        Convention => C,
        External_Name => "wiringPiSetupGpio";

    function WPi_Setup_Phys return Integer
        with
        Import,
        Convention => C,
        External_Name => "wiringPiSetupPhys";

   procedure WPi_Pin_Mode(Pin : Pin_Type; Mode : Mode_Type)
     with 
       Import,
       Convention => C,
       External_Name => "pinMode";
   
   
   procedure WPi_Digital_Write (Pin : Pin_Type; Value : Value_Type)
        with
        import,
        Convention => C,
        External_Name => "digitalWrite";

    function WPi_Digital_Read (Pin : Pin_Type) return Value_Type
        with
        Import,
        Convention => C,
        External_Name => "digitalRead";
         
   
end PI.GPIO;
