with Ada.Text_IO;
with Device;
with Logger; use Logger;
with Util;

package body Bed with 
  SPARK_Mode => On 
is  
   
   procedure Start(This : Object) is 
   begin 
      Device.GPIO.Pin_Mode(This.Head_Up_Pin, HAL.GPIO.Output); 
      Device.GPIO.Pin_Mode(This.Head_Down_Pin, HAL.GPIO.Output); 
      Device.GPIO.Pin_Mode(This.Feet_Up_Pin, HAL.GPIO.Output); 
      Device.GPIO.Pin_Mode(This.Feet_Down_Pin, HAL.GPIO.Output);      
   end Start;
   
   procedure Move(This : Object; Unit : Bed_Unit; Travel_Direction : Direction; Duration : Time_Milliseconds) is
   begin      
      if Unit = Head and Travel_Direction = Up then
         Move(This.Head_Up_Pin, Duration);
      elsif Unit = Head and Travel_Direction = Down then
         Move(This.Head_Down_Pin, Duration);
      elsif Unit = Foot and Travel_Direction = Up then 
         Move(This.Feet_Up_Pin, Duration);
      else 
         Move(This.Feet_Down_Pin, Duration);
      end if;
   end Move;
   
   procedure Move(Pin : Pin_Type; Duration : Time_Milliseconds) is 
   begin
         
      Log(Bed_Log, "Requesting Movement on Pin=" & Pin'Image);
         
      Bed_Control.Stop;
      
      -- Start the new movement
      Bed_Control.Start(Pin, Duration);
      
      if True then 
         Log(Bed_Log, "Movement Started.");
      end if;
            
   end Move;
        
   procedure Halt is 
   begin
      Bed_Control.Stop;
   end Halt;
   
   protected body Bed_Control is

      procedure Do_Stop_At(Pin : in out Pin_Type; Expiration_Slot : Time; Actual_Expiration_Slot : Time) is
      begin
         
         if Actual_Expiration_Slot = Expiration_Slot then
            -- needed to prove postcondition 
            pragma Assume (Control_Pin = Pin);
            Pin := Control_Pin;         
            Stop;
         else
            Pin := Pin_None;
         end if;
         
      end Do_Stop_At;
      
 
      
      procedure Stop_At(Pin : in out Pin_Type; Expiration_Slot : Time) is
      begin
         Do_Stop_At(Pin, Expiration_Slot, Expire_At);                           
      end Stop_At;           
        
      procedure Stop is         
      begin                                       
         Log(Bed_Bed_Control_Log, "Requesting stop of bed.");
         
         if Moving then 
            Log(Bed_Bed_Control_Log, "Stopping Movement on Pin=" & Control_Pin'Image);
            Device.GPIO.Digital_Write(Control_Pin, Low);
            Moving := False;            
            Log(Bed_Bed_Control_Log, "Movement stopped.");
         else
            Log(Bed_Bed_Control_Log, "Bed wasn't moving. Ignoring.");
         end if;         
         
         -- update ghosts 
         Bed_State_Ghost.Moving := Moving;        
         
      end Stop;
      
      procedure Start(Pin : Pin_Type; Duration : Time_Milliseconds) is
         Current_Time : Time := Ada.Real_Time.Clock;
      begin              
         Control_Pin := Pin;
         Expire_At := Current_Time + Milliseconds(Duration);
        

         Log(Bed_Bed_Control_Log, "Starting Movement on Pin=" & Control_Pin'Image);
         Device.GPIO.Digital_Write(Control_Pin, High);
         Moving := True;
         
         -- update ghosts
         Bed_State_Ghost.Expire_At := Expire_At;
         Bed_State_Ghost.Moving := Moving;
      end Start;                 
      
      entry Get_Termination_Time(Expire_At : out Time; Pin : out Pin_Type) 
        -- don't allow anyone to check the expiration time
        -- if the bed isn't moving
        when Moving is
      begin         
         Expire_At := Bed_Control.Expire_At;         
         Pin := Control_Pin;
      end Get_Termination_Time;
      
      function Get_Expire_At return Time is
      begin
         return Expire_At;
      end Get_Expire_At;
      
      function Get_Control_Pin return Pin_Type is
      begin
         return Control_Pin;
      end Get_Control_Pin;
      
   end Bed_Control;

   task body Timer_Task is 
      Expire_At : Time;
      Control_Pin : Pin_Type;
   begin      
      loop 
         -- this barrier will only release if 
         -- the bed is moving        
         Bed_Control.Get_Termination_Time(Expire_At, Control_Pin);
         declare             
            Current_Time : Time := Ada.Real_Time.Clock;
            Current_Control_Pin : Pin_Type := Control_Pin;
         begin
            
            if Current_Time >= Expire_At then
               Log(Bed_Timer_Task_Log, "Resolving Timer.");

               Bed_Control.Stop_At(Current_Control_Pin, Expire_At); 
            else
               delay until Util.Next_N_Ms(100);               
            end if;
         end;
      end loop;
   end Timer_Task;       
   
end Bed;
