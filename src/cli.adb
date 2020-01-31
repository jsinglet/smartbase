with Ada.Text_IO;
with Bed; 
with RandomInteger;
with Ada.Real_Time; use Ada.Real_Time;
with System_Test; use System_Test;

package body CLI is
   
   package Log renames Ada.Text_IO;


   task body Command_Interface is
      Command : String(1..10);
      Last : Natural := 0;
      B : Bed.Object;
   begin    
      
      loop
         -- protected barrier to allow pausing of command line.
         Command_Control.Enabled;
           
         B := Command_Control.Get_Bed;
         
         Log.Put("smartbase> ");

         Ada.Text_IO.Get_Line(Command, Last);
            
         Handle_Command(B, Command(1..Last));
         
      end loop;           
   end Command_Interface;

   
   protected body Command_Control is 
      procedure Enable(The_Bed : Bed.Object) is
      begin
         Command_Control.The_Bed := The_Bed;         
         Enable_Commandline := True;
      end Enable;
      
      procedure Disable is 
      begin
         Enable_Commandline := False;
      end Disable;
      
      function Get_Bed return Bed.Object is
      begin
         return The_Bed;
      end Get_Bed;
      
      entry Enabled 
        when Enable_Commandline is
      begin         
         null;
      end Enabled;                  
   end Command_Control;
   
      
   
   
   
   
end CLI;
