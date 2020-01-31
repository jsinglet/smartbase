with Bed; use Bed;
with Commands; use Commands;
package CLI is

   
   protected Command_Control is
      procedure Enable(The_Bed : Bed.Object);
      procedure Disable;
      
      entry Enabled;
      function Get_Bed return Bed.Object;
   private
      Enable_Commandline : Boolean := False;
      The_Bed : Bed.Object;
   end Command_Control;
   

   task Command_Interface with Priority => 5; 
end CLI;
