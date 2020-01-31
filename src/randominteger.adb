with Ada.Numerics.Discrete_Random;
package body RandomInteger is

   function Next_Integer ( n: in Positive) return Integer is
   begin
      return Rand_Int.Random(gen) mod n; 
   end Next_Integer;   
   
  
begin
   Rand_Int.Reset(gen);

end RandomInteger;

