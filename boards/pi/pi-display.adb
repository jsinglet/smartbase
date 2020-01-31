with Ada.Text_IO; 
package body PI.Display is

   procedure Write_To_Screen(This: Console_Display; Buffer : in String) is 
   begin
      Ada.Text_IO.Put_Line(Buffer);
   end Write_To_Screen;
     

end PI.Display;
