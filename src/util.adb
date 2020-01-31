package body Util is

   function Next_N_Ms(MS : Integer) return Time is
   begin
      return Ada.Real_Time.Clock + Milliseconds(MS);
   end Next_N_Ms;

end Util;
