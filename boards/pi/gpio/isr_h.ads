pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package isr_h is

   procedure register_isr_1 (arg1 : int; arg2 : int);  -- isr.h:1
   pragma Import (C, register_isr_1, "register_isr_1");

end isr_h;
