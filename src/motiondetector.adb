with Logger; use Logger;
with Device;
with HAL.GPIO; use HAL.GPIO;
with Util;
with LED; use LED;

package body MotionDetector is

   procedure Initialize_Hardware is
   begin
      Device.GPIO.Register_ISR_1(Pins     => Device.Motion_Detector_Pins,
                                 Mode     => RISING,
                                 Callback => Motion_Detected'Access);
   end Initialize_Hardware;
   
   procedure Motion_Detected is 
   begin
      Log(MotionDetector_Log, "Detected Motion...");
      
      MotionDetector_Control.Start(Duration => Default_Duration);
      
   end Motion_Detected;
   
   
   protected body MotionDetector_Control is
      
      procedure Stop(Expiration_Slot : Time) is
      begin
         Log(MotionDetector_Log, "[Control] Motion detector timeout");
         
         if Expire_At = Expiration_Slot then
            LED_Status_Manager.Set_Status(FADE_OFF);
            Detecting := False;
         end if;
         
      end Stop;
        
      
      procedure Start(Duration : Time_Milliseconds) is
         Current_Time : Time := Ada.Real_Time.Clock;
      begin              
         Log(MotionDetector_Log, "[Control] Triggering Motion detection.");

         Expire_At := Current_Time + Milliseconds(Duration);

         LED_Status_Manager.Set_Status(FADE_ON);
         
         Detecting := True;
      end Start;                 
      
      entry Get_Termination_Time(Expire_At : out Time) 
        when Detecting is
      begin         
         Expire_At := MotionDetector_Control.Expire_At;         
      end Get_Termination_Time;
      
   end MotionDetector_Control;
   
   task body Timer_Task is 
      Expire_At : Time;
   begin      
      loop 
         MotionDetector_Control.Get_Termination_Time(Expire_At);
         declare             
            Current_Time : Time := Ada.Real_Time.Clock;
         begin
            
            if Current_Time >= Expire_At then
               Log(MotionDetector_Log, "Resolving Timer.");

               MotionDetector_Control.Stop(Expire_At); 
            else
               delay until Util.Next_N_Ms(100);               
            end if;
         end;
      end loop;
   end Timer_Task;       
   
   
   

end MotionDetector;
