;
; led.asm
;
; Created: 08.09.2021 11:50:05
; Author : Daniel Aniœko
;
.def rej = r18
.def temp    = r16  
.def seg = r17
.def delay_o = r19 ;rejestry do opóŸnien
.def delay_m = r20
.def delay_y = r21
	.cseg
	.org 0
	jmp Reset
Reset: 
	cli ;Wy³¹czenie przerwañ
	ldi rej,high(RAMEND) ; Ustawienie wskaŸnika stosu na górê RAMU
	out SPH,rej ;
	ldi rej,low(RAMEND) ;
	out SPL,rej 
	sei
	ser temp             ; DDRB as outputs 
	out DDRA, temp       ; 
	ser seg
	out DDRC, seg
	ldi seg, 0b00111100
	out PortC, seg
	;Set bit pattern to display 0 initially 
	ldi temp,  0b00000000; 
	out PortA, temp ; 
	
Main: 
	ldi temp, 0b10000000 ;
main_loop:
	out DDRA, temp
	CALL delay
	LSR temp
	SBRS temp, 0
	rjmp main_loop
	rjmp Main

delay: 
	 
	 ldi delay_o, 0
	 ldi delay_m, 0
	 ldi delay_y, 10
	 CALL loop
	 RET
loop:	
		dec delay_o
		brne loop
		dec delay_m
		brne loop
		dec delay_y 
		brne loop
		RET
