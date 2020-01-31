with Bed; use Bed;

package Commands is

   type Command_Type is (
                         HeadUp,
                         HeadDown,
                         FeetUp,
                         FeetDown,
                         TestUnits,
                         FadeOn,
                         FadeOff,
                         Connecting,
                         Connected
                        );

   Command_HeadUp : constant String := "headup";
   Command_HeadDown : constant String := "headdown";
   Command_FeetUp : constant String := "feetup";
   Command_FeetDown : constant String := "feetdown";
   Command_TestUnits : constant String := "testunits";
   Command_FadeOn    : constant String := "fadeon";
   Command_FadeOff    : constant String := "fadeoff";
   Command_Connecting    : constant String := "connecting";
   Command_Connected    : constant String := "connected";



   Command_Off : constant String := "off";
   Command_On  : constant String := "on";

   procedure Handle_Command(B : Bed.Object; Command : String);

end Commands;
