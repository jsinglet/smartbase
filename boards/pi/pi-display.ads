with HAL.Display; use HAL.Display;

package PI.Display is

   type Console_Display is new Display_Type with null record;
      
   overriding
   procedure Write_To_Screen(This : Console_Display; Buffer : in String);

      
end PI.Display;
