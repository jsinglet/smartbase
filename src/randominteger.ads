with Ada.Numerics.Discrete_Random;
package RandomInteger with SPARK_Mode => On is

   subtype Rand_Range is Positive;
   package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);

   Gen : Rand_Int.Generator;

   function Next_Integer ( n: in Positive) return Integer;
   
end RandomInteger;
