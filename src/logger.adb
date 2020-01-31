package body Logger with
  SPARK_Mode => On
is
   procedure Log(Category : Logger_Type; Message : String) is separate;
end Logger;
