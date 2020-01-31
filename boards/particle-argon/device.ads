with NRF52_SVD.Device; use NRF52_SVD.Device;

with HAL.GPIO; use HAL.GPIO;
with Argon.Display;
with Argon.GPIO;

package Device is
   Display : Argon.Display.Console_Display;
   GPIO    : Argon.GPIO.Argon_GPIO;



   D0 : constant Pin_Type := P0_26; -- SDA
   D1 : constant Pin_Type := P0_27; -- SCL
   D2 : constant Pin_Type := P1_01;
   D3 : constant Pin_Type := P1_02;
   D4 : constant Pin_Type := P1_08;
   D5 : constant Pin_Type := P1_10;
   D6 : constant Pin_Type := P1_11;
   D7 : constant Pin_Type := P1_12;
   D8 : constant Pin_Type := P1_03;
   D9 : constant Pin_Type := P0_06; -- tx
   D10 : constant Pin_Type := P0_08; -- rx
   D11 : constant Pin_Type := P1_14; -- MISO
   D12 : constant Pin_Type := P1_13; -- MOSI
   D13 : constant Pin_Type := P1_15; -- SCK

   A0 : constant Pin_Type := P0_03;
   A1 : constant Pin_Type := P0_04;
   A2 : constant Pin_Type := P0_28;
   A3 : constant Pin_Type := P0_29;
   A4 : constant Pin_Type := P0_30;
   A5 : constant Pin_Type := P0_31;

   LED_R : constant Pin_Type := P0_13;
   LED_G : constant Pin_Type := P0_14;
   LED_B : constant Pin_Type := P0_15;




   -- Pin Definitions
   Head_Up_Pin : constant Pin_Type := D3;
   Head_Down_Pin : constant Pin_Type := D4;
   Feet_Up_Pin : constant Pin_Type := D5;
   Feet_Down_Pin : constant Pin_Type := D6;

end Device;
