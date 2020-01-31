with HAL.GPIO; use HAL.GPIO;

package NRF52_SVD.Device is

   P0_02 : constant Pin_Type := 2;
   P0_03 : constant Pin_Type := 3;
   P0_04 : constant Pin_Type := 4;
   P0_05 : constant Pin_Type := 5;
   P0_06 : constant Pin_Type := 6;
   P0_07 : constant Pin_Type := 7;
   P0_08 : constant Pin_Type := 8;
   P0_11 : constant Pin_Type := 11;
   P0_12 : constant Pin_Type := 12;
   P0_13 : constant Pin_Type := 13;
   P0_14 : constant Pin_Type := 14;
   P0_15 : constant Pin_Type := 15;
   P0_16 : constant Pin_Type := 16;
   P0_17 : constant Pin_Type := 17;
   P0_18 : constant Pin_Type := 18;
   P0_19 : constant Pin_Type := 19;
   P0_20 : constant Pin_Type := 20;
   P0_21 : constant Pin_Type := 21;
   P0_22 : constant Pin_Type := 22;
   P0_23 : constant Pin_Type := 23;
   P0_24 : constant Pin_Type := 24;
   P0_25 : constant Pin_Type := 25;
   P0_26 : constant Pin_Type := 26;
   P0_27 : constant Pin_Type := 27;
   P0_28 : constant Pin_Type := 28;
   P0_29 : constant Pin_Type := 29;
   P0_30 : constant Pin_Type := 30;
   P0_31 : constant Pin_Type := 31;


   P1_Offset : constant Integer := 100;
   -- to enable us to tell between port 1 and port zero pins
   -- we offset port 1 pins by 100.
   P1_00 : constant Pin_Type := 0 + P1_Offset;
   P1_01 : constant Pin_Type := 1 + P1_Offset;
   P1_02 : constant Pin_Type := 2 + P1_Offset;
   P1_03 : constant Pin_Type := 3 + P1_Offset;
   P1_04 : constant Pin_Type := 4 + P1_Offset;
   P1_05 : constant Pin_Type := 5 + P1_Offset;
   P1_06 : constant Pin_Type := 6 + P1_Offset;
   P1_07 : constant Pin_Type := 7 + P1_Offset;
   P1_08 : constant Pin_Type := 8 + P1_Offset;
   P1_09 : constant Pin_Type := 9 + P1_Offset;
   P1_10 : constant Pin_Type := 10 + P1_Offset;
   P1_11 : constant Pin_Type := 11 + P1_Offset;
   P1_12 : constant Pin_Type := 12 + P1_Offset;
   P1_13 : constant Pin_Type := 13 + P1_Offset;
   P1_14 : constant Pin_Type := 14 + P1_Offset;
   P1_15 : constant Pin_Type := 15 + P1_Offset;

end NRF52_SVD.Device;
