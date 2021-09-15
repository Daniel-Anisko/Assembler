/*
 * main.c
 *
 * Created: 9/9/2021 9:17:55 AM
 *  Author: danisko
 */ 

#include <xc.h>
#include <avr/io.h>
#include "multiplex/multipleks.h"
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include <util/delay.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main(void)
{
  _init();
  sei();
  digs[0] = 0;
  digs[1] = 0;
  digs[2] = 0;
  digs[3] = 0;


  
		  

    while(1)
    {
				 _delay_ms(480000);
				 digs[3]++;
				 
				 if(digs[3] == 10){
					 digs[2]++;
					 digs[3] = 0;
				 }
				 if(digs[2] == 10){
					 digs[1]++;
					 digs[2] = 0;
					 digs[3] = 0;
				 }
				 if(digs[1] == 10){
					 digs[0]++;
					 digs[1] = 0;
					 digs[2] = 0;
					 digs[3] = 0;
				 }
				 if(digs[2] == 6 && digs[3] == 0){
					 digs[1]++;
					 digs[2] = 0;
					 digs[3] = 0;
				 }
				 if(digs[0] == 2 && digs[1] == 3 && digs[2] == 5 && digs[3] == 9){
					 digs[0] = 0;
					 digs[1] = 0;
					 digs[2] = 0;
					 digs[3] = 0;
				 }


		}
		
}