with Device;
with HAL.GPIO; use HAL.GPIO;
with Ada.Real_time; use Ada.Real_Time;


package Bed with 
  SPARK_Mode => On 
is
      
   subtype Time_Milliseconds is Integer range 1..60000; 
   
   subtype Valid_Pin is Pin_Type
     with Static_Predicate => Valid_Pin /= Pin_None;
   
   type Object is tagged record 
      Head_Up_Pin : Valid_Pin;
      Head_Down_Pin : Valid_Pin;
      Feet_Up_Pin : Valid_Pin;
      Feet_Down_Pin : Valid_Pin;      
   end record;
      
   type Bed_Unit is (
                     Head, 
                     Foot
                    );

   type Direction is (
                      Up, 
                      Down
                     );
   
   procedure Move(
                  This : Object; 
                  Unit : Bed_Unit; 
                  Travel_Direction : Direction; 
                  Duration : Time_Milliseconds
                 );   
      
   procedure Move(Pin : Pin_Type; Duration : Time_Milliseconds) with
     Pre => Pin /= Pin_None;
   
   
   procedure Halt;
         
   -- the version of Ada that runs on 
   -- linux (ARM) that is downloadable 
   -- doesn't support correctly generating 
   -- code that contains ghost variables. 
   package Bed_State_Ghost
     -- with Ghost 
   is
      Moving : Boolean := False;
      Expire_At : Time := Ada.Real_Time.Time_Last;
   end Bed_State_Ghost;
      
   
   
   protected Bed_Control is
      
      procedure Do_Stop_At(Pin : in out Pin_Type; Expiration_Slot : Time; Actual_Expiration_Slot : Time)
        with
          Contract_Cases => (
                             -- the slots match. This means
                             -- we will be performing the action 
                             -- on the pin we expected.
                             (Actual_Expiration_Slot = Expiration_Slot) => Pin'Old = Pin,
                             -- the slots DON'T match, which means we missed our window
                             (Actual_Expiration_Slot /= Expiration_Slot) => Pin = Pin_None
                            );
                                 
      procedure Stop_At(Pin : in out Pin_Type; Expiration_Slot : Time);
                 
      procedure Stop
        with 
          Global => (Input => (Device.GPIO),
                     Output => (Bed_State_Ghost.Moving)),
        Pre  => True,
        Post => Bed_State_Ghost.Moving = False;
      
      procedure Start(Pin : Pin_Type; Duration : Time_Milliseconds) 
        with
          Global => (Input  => (Device.GPIO, Ada.Real_Time.Clock_Time), 
                     Output => (
                                      Bed_State_Ghost.Moving,
                                      Bed_State_Ghost.Expire_At
                               )),
          Pre => Pin /= Pin_None,
          Post => Bed_State_Ghost.Moving = True;
                       
      entry Get_Termination_Time(Expire_At : out Time; Pin : out Pin_Type);  
      function Get_Control_Pin return Pin_Type;
      function Get_Expire_At return Time;
      
   private 
      Control_Pin : Pin_Type := 0;
      Moving : Boolean := False;     
      Expire_At : Time := Ada.Real_Time.Time_Last;
   end Bed_Control;
            
   procedure Start(This : Object);   
private 

   task Timer_Task with Priority => 5;
end Bed;
