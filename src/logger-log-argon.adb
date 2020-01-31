with Logger;

separate(Logger)
procedure Log(Category : Logger_Type; Message : String) is
begin
   -- don't do anything when doing verification.
   null;
end Log;
