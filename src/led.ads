with HAL.LED; use HAL.LED;

package LED is

   -- Other colors
   Red : constant Color := (255, 0, 0);
   Green : constant Color := (0, 255, 0);

   -- Colors used while fading
   Fade_Color : Color := (255, 165, 0);
   Fade_Brightness : Integer := 255;
   
   -- Colors used while connecting
   Connecting_Foreground : Color := (0, 255, 255);
   Connecting_Background : Color := (0, 0, 255);
   Connecting_Brightness : Integer := 127;
   Connecting_Width      : Integer := 3;
   Connecting_Pulses     : Integer := 1;
   Connecting_Pulse_Speed : Integer := 1000;
   
   -- Color to use when connected
   Connected_Color : Color := Green;
   Connected_Brightness : Integer := 255;   
   Connected_Pulses : Integer := 2;
   Connected_Pulse_Speed : Integer := 250;
   

   type LED_Status_Type is (
                            CONNECTING, 
                            CONNECTED,
                            FADE_ON,
                            FADE_OFF,
                            OFF,
                            NONE,
                            NONE_FADE_ON
                            );
   
   -- Tasks and control objects
   protected LED_Status_Manager is
      procedure Set_Status(New_Status : LED_Status_Type);
      
      entry Active;

      function Get_Status return LED_Status_Type;
   private
      Status : LED_Status_Type := OFF;
      -- We start in an active state to allow
      -- the system to turn off the LEDs if they are
      -- active.
      Is_Active : Boolean := True; 
   end LED_Status_Manager;
   
   task LED_Status_Task with Priority => 5; 

end LED;
