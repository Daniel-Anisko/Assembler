/*
 * multipleks.h
 *
 * Created: 09.09.2021 09:21:22
 *  Author: danisko
 */ 


#ifndef MULTIPLEKS_H_
#define MULTIPLEKS_H_

#define segPort PORTA
#define segDDR DDRA
 
#define digPort PORTD
#define digDDR DDRD

#define swPort PORTC
#define swDDR DDRC

#define dig1 (1<<PD0)
#define dig2 (1<<PD1)
#define dig3 (1<<PD2)
#define dig4 (1<<PD3)
#define sw (1<<PC2)
#define mask (dig1|dig2|dig3|dig4)
extern uint8_t digs[4];
void   _init(void);

#endif /* MULTIPLEKS_H_ */