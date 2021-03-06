;
; Snake_Atmega32.asm
;
; Created: 08.09.2021 08:17:59
; Author : Daniel Ani?ko
;
;------------------------Dyrektywy---------------------------------
	 .nolist ;
	 .list ;
	 .listmac ;
	 .def rej = r16 ; Pierwszy dozwolony rejestr dla instrukcji ldi
	 .def Ledy = r20 ; Rejestr przechowujacy Piny di?d
	 .def delay_o = r19 ;rejestry do op??nien
	 .def delay_m = r18
	 .def delay_y = r17
	 .equ SwPort = PORTD ; Port dla przycisk?w
	 .equ Sw0Pin = 0 ; Piny przycisk?w
	 .equ Sw1Pin = 1 ;
	 .equ SwKierunek = SwPort - 1 ; Ustawienie kierunku (DDRD)
	 .equ SwPiny = SwPort - 2  ; 
	 .cseg ;
	 .org 0 ;Pocz?tek zapisu 
	 rjmp rst ;
;

;---------------------------RESET-------------------------------------------
rst: 
	
	 cli ;Wy??czenie przerwa?
	 ldi rej,high(RAMEND) ; Ustawienie wska?nika stosu na g?r? RAMU
	 out SPH,rej ;
	 ldi rej,low(RAMEND) ;
	 out SPL,rej ;
	 ;
	 cbi SwKierunek,Sw0Pin ; Ustawienie wej?? i wyj?? oraz ustawienie wysokich stan?w
	 sbi SwPort,Sw0Pin ;
	 ;
	 cbi SwKierunek,Sw1Pin ; 
	 sbi SwPort,Sw1Pin ; 
	 ;
	 ldi r20, 0xFF
	 out DDRB, r20
	 out PORTB, r20
;-----------------------------MAIN-------------------------- 
main:

	 in rej,SwPiny
	 sbrs rej,Sw0Pin
	 rjmp OFF_P
	 sbrs rej,Sw1Pin
	 rjmp OFF_L 
	 rjmp main
	 ;
; ----------------------------LEWO----------------------------
ON_L:  
     
	 out DDRB, r20 ; przepisanie stanow wyjsc z rejestru r20 do DDRB
	 CALL delay ; wywo?anie op??nienia
	 LSL r20 ;przesuni?cie bitowe w lewo
	 SBR r20, 0x01 ; przypisanie 1 do MSB
	 SBRS r20, 7 ; je?eli 11111111, przeskocz do wy??czania
	 rjmp ON_L
OFF_L: 
	 
	 out DDRB, r20
	 CALL delay
	 LSL r20
	 brne OFF_L
	 sbrs rej,Sw0Pin
	 rjmp ON_P
	 rjmp ON_L

;------------------------------PRAWO--------------------------
ON_P:  
	 
	 out DDRB, r20
	 CALL delay
	 LSR r20
	 SBR r20, 0b10000000
	 SBRS r20,0
	 rjmp ON_P
	
OFF_P:
	 
	 out DDRB, r20
	 CALL delay
	 LSR r20
	 brne OFF_P
	 rjmp ON_P
;------------------------------DELAY-------------------------
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

.exit