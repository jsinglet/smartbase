pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;

package ws2812b_led_h is

   function show return int;  -- ws2812b-led.h:3
   pragma Import (C, show, "show");

   function c_begin (arg1 : int; arg2 : int) return int;  -- ws2812b-led.h:4
   pragma Import (C, c_begin, "begin");

   procedure setBrightness (arg1 : short);  -- ws2812b-led.h:5
   pragma Import (C, setBrightness, "setBrightness");

   procedure setPixelColor
     (arg1 : int;
      arg2 : int;
      arg3 : int;
      arg4 : int;
      arg5 : int);  -- ws2812b-led.h:6
   pragma Import (C, setPixelColor, "setPixelColor");

end ws2812b_led_h;
