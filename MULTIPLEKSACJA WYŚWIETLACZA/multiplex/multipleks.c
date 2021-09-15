/*
 * multipleks.c
 *
 * Created: 09.09.2021 09:21:10
 *  Author: danisko
 */ 

#include <avr/io.h>
#include "multipleks.h"
#include <avr/pgmspace.h>
#include <avr/interrupt.h>
#include <stdio.h>
#include <util/delay.h>
#include <stdio.h>
#include <stdlib.h>
const uint8_t cyfry[] PROGMEM = {
		0b11000000, // 0
		0b11111001, // 1
		0b10100100, // 2
		0b10110000, // 3
		0b10011001, // 4
		0b10010010, // 5
		0b10000010, // 6
		0b11111000, // 7
		0b00000000, // 8
		0b10010000, // 9
		0xFF
		
};
uint8_t digs[4];
void _init(void){
	segDDR = 0xFF;
	segPort = 0x00;
	
	digDDR =0xff;
	digPort = 0x00;
	
	swDDR = 0x00;
	swPort = 0x01;
	
	TCCR0 = (1<<WGM01) | (1<<CS02) | (1<<CS00);
	OCR0 = 10;
	TIMSK = (1<<OCIE0);
	
	
	
}

ISR(TIMER0_COMP_vect){
	static uint8_t licznik;
	segPort = pgm_read_byte(&cyfry[digs[licznik]]);
	digPort = ( digPort & ~mask) | (~(1<<licznik) & mask);
	licznik++;
	if(licznik > 3 ) licznik = 0;
}
