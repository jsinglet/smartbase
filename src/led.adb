with Device; use Device;
with Util; use Util;
with Logger; use Logger;

package body LED is
   
   protected body LED_Status_Manager is
      
      procedure Update_Status(New_Status : LED_Status_Type) is 
      begin
         Log(LED_Log, "Executing State Transition FROM=" & Status'Image & " To=" & New_Status'Image);                                
         Status      := New_Status;
      end Update_Status;
        

      procedure Reject_Status(New_Status : LED_Status_Type) is 
      begin
         Log(LED_Log, "Rejecting State Transition FROM=" & Status'Image & " To=" & New_Status'Image);                                
      end Reject_Status;

      procedure Set_Status(New_Status : LED_Status_Type) is
      begin
         
         
         case Status is

            when OFF =>
               
               if New_Status = CONNECTING or New_Status = NONE then 
                  Update_Status(New_Status);
               else
                  Reject_Status(New_Status);
               end if;
               
            when CONNECTED =>
               if New_Status = NONE or New_Status = OFF then 
                  Update_Status(New_Status);
               else
                  Reject_Status(New_Status);
               end if;
               

            when CONNECTING =>
               
               if New_Status = CONNECTED then 
                  Update_Status(New_Status);
               elsif New_Status = OFF then 
                  Update_Status(New_Status);
               else
                  Reject_Status(New_Status);
               end if;
               
            when NONE => 
               
               if New_Status = CONNECTING then 
                  Update_Status(New_Status);
               elsif New_Status = CONNECTED then 
                   Update_Status(New_Status);  
               elsif New_Status = OFF then 
                  Update_Status(New_Status);
               elsif New_Status = FADE_ON then 
                  Update_Status(New_Status);
               else
                  Reject_Status(New_Status);
               end if;

            when FADE_ON =>
               if New_Status = NONE_FADE_ON then 
                  Update_Status(New_Status);
               elsif New_Status = CONNECTING then 
                  Update_Status(New_Status);
               else
                  Reject_Status(New_Status);
               end if;
               
            when FADE_OFF => 
               if New_Status = NONE then 
                  Update_Status(New_Status);
               elsif New_Status = CONNECTING then 
                  Update_Status(New_Status);
               else 
                  Reject_Status(New_Status);
               end if;
               
            when NONE_FADE_ON =>
               
               if New_Status = FADE_OFF then 
                  Update_Status(New_Status);
               elsif New_Status = CONNECTING then 
                  Update_Status(New_Status);
               else
                  Reject_Status(New_Status);
               end if;               
         end case;
         
         if Status /= NONE and Status /= NONE_FADE_ON then 
            Is_Active := True;
         else 
            Is_Active := False;
         end if;
         
      end Set_Status;

      entry Active 
        when Is_Active is
      begin         
         null;
      end Active;    
      
      function Get_Status return LED_Status_Type is
      begin
         return Status;
      end Get_Status;
   end LED_Status_Manager;
   
   ---------------------
   -- LED_Status_Task --
   ---------------------

   task body LED_Status_Task is 
      Current_Status : LED_Status_Type;  
      Counter_Connecting : Integer := 0;
   begin

      loop 
         
         
         -- Entry barrier --
         LED_Status_Manager.Active;

         Current_Status := LED_Status_Manager.Get_Status;
         
         case Current_Status is
            when OFF => 
               Log(LED_Log, "Status is OFF, Turning Device Off.");
               Device.LED.All_Off;
               LED_Status_Manager.Set_Status(NONE); -- this always stops the loop               
            when FADE_ON => 
               Log(LED_Log, "Status is FADEON, Fading...");
               Device.LED.Fade_On(LED_Color => Fade_Color,
                                  Max_Brightness => Fade_Brightness);
               Log(LED_Log, "Setting status to NONE");
               LED_Status_Manager.Set_Status(NONE_FADE_ON);

            when FADE_OFF => 
               Log(LED_Log, "Status is FADE_OFF");
               Device.LED.Fade_Off(LED_Color => Fade_Color,
                                   Max_Brightness =>  Fade_Brightness);
               
               Log(LED_Log, "Setting status to NONE");
               LED_Status_Manager.Set_Status(NONE);

            when CONNECTING => 
               Log(LED_Log, "Status is CONNECTING with Counter Value=" & Counter_Connecting'Image);

               Device.LED.Pulse(LED_Color      => Connecting_Foreground,
                                Num_Pulses     => Connecting_Pulses,
                                Max_Brightness => Connecting_Brightness,
                                Pulse_Length => Connecting_Pulse_Speed);
               
              
            when CONNECTED =>
               Log(LED_Log, "Status is CONNECTED");
               Device.LED.Pulse(LED_Color      => Connected_Color,
                                Num_Pulses     => Connected_Pulses,
                                Max_Brightness => Connected_Brightness,
                                Pulse_Length =>  Connected_Pulse_Speed);
                 
               Log(LED_Log, "Setting status to NONE");
               LED_Status_Manager.Set_Status(NONE);
            when others => null;
         end case;
         
      end loop;
      
         
                  
   end LED_Status_Task;
      

end LED;
