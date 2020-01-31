with RandomInteger;
with Util; use Util;

package body System_Test is

   procedure Test_Unit(B : Bed.Object; Unit : Bed_Unit; D : Direction) is 
   begin
      for I in 1..5 loop
         B.Move(
                Unit => Unit,
                Travel_Direction => D,
                Duration => 10000
               );
         delay until Next_N_Ms(100);
         Bed.Halt;
         delay until Next_N_Ms(100);
      end loop;
      
   end Test_Unit;
   
   
   type Unit_Array is array (Natural range <>) of Bed_Unit;
   type Direction_Array is array (Natural range <>) of Direction;
   
   
   procedure Test_Units(B : Bed.Object) is 
      Next_Unit : Integer;
      Next_Direction : Integer;
      
      Units : Unit_Array := (Head, Foot);
      Directions : Direction_Array := (Up, Down);
      
   begin
      Test_Unit(B, Head, Up);
      Test_Unit(B, Head, Down);
      Test_Unit(B, Foot, Up);
      Test_Unit(B, Foot, Down);   
      
      -- now randomly test all units
      --Log.Put_Line("Randomly testing....");
      
      for I in 1..100 loop
         Next_Unit := RandomInteger.Next_Integer(2);
         Next_Direction := RandomInteger.Next_Integer(2);
         
          B.Move(
                Unit => Units(Next_Unit),
                Travel_Direction => Directions(Next_Direction),
                Duration => 10000
               );
         delay until Next_N_Ms(10);
         Bed.Halt;
         delay until Next_N_Ms(10);
      end loop;           
   end Test_Units;


end System_Test;
