#include "isr.h"
#include <stdio.h>
#include <wiringPi.h> 

extern void smartbase_call_isr_1();

void isr_1(){
  smartbase_call_isr_1();
}


void register_isr_1(int pin, int mode) {
    pinMode(pin, INPUT);
    pullUpDnControl(pin, PUD_DOWN);
    wiringPiISR(pin, mode, &isr_1);
}
