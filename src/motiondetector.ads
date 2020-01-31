with Ada.Real_time; use Ada.Real_Time;

package MotionDetector is

   procedure Initialize_Hardware;
   procedure Motion_Detected;
   
   subtype Time_Milliseconds is Integer range 1..60000; 

   
   Default_Duration : constant Time_Milliseconds := 10000;
   
private 
   task Timer_Task with Priority => 5;
   
   protected MotionDetector_Control is
      

      procedure Stop(Expiration_Slot : Time);
      procedure Start(Duration : Time_Milliseconds);
                       
      entry Get_Termination_Time(Expire_At : out Time);  
      
   private 
      Detecting : Boolean := False;     
      Expire_At : Time := Ada.Real_Time.Time_Last;
   end MotionDetector_Control;
   
end MotionDetector;
