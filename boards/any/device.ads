with HAL.GPIO; use HAL.GPIO;
with Any.Display;
with Any.GPIO;
with Any.LED;

package Device with
  SPARK_Mode => On
is
   Display : Any.Display.Console_Display;
   GPIO    : Any.GPIO.Console_GPIO;
   LED     : Any.LED.Any_LED := (GPIO_Pin => 12, Number_Of_LEDs => 4);


   -- Pin Definitions
   Head_Up_Pin : constant Pin_Type := 37;
   Head_Down_Pin : constant Pin_Type := 35;
   Feet_Up_Pin : constant Pin_Type := 33;
   Feet_Down_Pin : constant Pin_Type := 31;

end Device;
