/*
 * LAB8_3.c
 *
 * Created: 8/14/2011 3:51:59 PM
 *  Author: Job
 */ 

#define F_CPU 8000000UL
#include <avr/io.h>


int main( void )
{

 DDRB|=(1<<PB7);
 PORTB=0;
 TCCR1A|=(1<<WGM10)|(1<<COM1C1)|(1<<COM1C0);
 TCCR1B|=(1<<CS10);
 TCNT1L=0x00;
 TCNT1H=0x00;
 OC1C = 0x2f;     //output PB7
 while(1)
 {}
}
