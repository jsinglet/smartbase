with HAL.GPIO; use HAL.GPIO;
with PI.Display;
with PI.GPIO;
with PI.LED;

package Device is

   -- Pin Definitions
   Head_Up_Pin : constant Pin_Type := 37;
   Head_Down_Pin : constant Pin_Type := 33;
   Feet_Up_Pin : constant Pin_Type := 31;
   Feet_Down_Pin : constant Pin_Type := 29;

   LED_Pin : constant Pin_Type := 12; -- this implementation uses PWM to control the LED. On the PI we use GPIO 12 (pin 32)

   -- 11 = Front; 16= Wife; 18 = Me
   Motion_Detector_Pins : Pin_Array := (11, 16, 18);

   -- Device Handles
   Display : PI.Display.Console_Display;
   GPIO    : PI.GPIO.PI_GPIO;
   LED     : PI.LED.PI_LED := (GPIO_Pin => LED_Pin, Number_Of_LEDs => 22);

end Device;
