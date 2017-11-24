
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 6
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;ProjectTest.c,2 :: 		int main(void)
;ProjectTest.c,4 :: 		DDRB = 0xFF;
	LDI        R27, 255
	OUT        DDRB+0, R27
;ProjectTest.c,5 :: 		DDRA = 0;
	LDI        R27, 0
	OUT        DDRA+0, R27
;ProjectTest.c,6 :: 		DDRD = 0xFF;
	LDI        R27, 255
	OUT        DDRD+0, R27
;ProjectTest.c,7 :: 		DDRE = 0xFF;
	LDI        R27, 255
	OUT        DDRE+0, R27
;ProjectTest.c,8 :: 		DDRC = 0xFF;
	LDI        R27, 255
	OUT        DDRC+0, R27
;ProjectTest.c,9 :: 		ADCSRA = 0x87;
	LDI        R27, 135
	OUT        ADCSRA+0, R27
;ProjectTest.c,10 :: 		ADMUX = 0xC0;
	LDI        R27, 192
	OUT        ADMUX+0, R27
;ProjectTest.c,12 :: 		while(1)
L_main0:
;ProjectTest.c,14 :: 		if(PINA&0x10)
	IN         R16, PINA+0
	SBRS       R16, 4
	JMP        L_main2
;ProjectTest.c,16 :: 		if(count>0){
	LDS        R18, _count+0
	LDS        R19, _count+1
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main21
	JMP        L_main3
L__main21:
;ProjectTest.c,17 :: 		PORTE=0x02;
	LDI        R27, 2
	OUT        PORTE+0, R27
;ProjectTest.c,18 :: 		count--;
	LDS        R16, _count+0
	LDS        R17, _count+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _count+0, R16
	STS        _count+1, R17
;ProjectTest.c,19 :: 		}
L_main3:
;ProjectTest.c,20 :: 		PORTE=0x00;
	LDI        R27, 0
	OUT        PORTE+0, R27
;ProjectTest.c,22 :: 		}
	JMP        L_main4
L_main2:
;ProjectTest.c,24 :: 		int tmp = 0;
	LDI        R27, 0
	STD        Y+0, R27
	STD        Y+1, R27
	LDI        R27, 0
	STD        Y+2, R27
	STD        Y+3, R27
	LDI        R27, 0
	STD        Y+4, R27
	STD        Y+5, R27
;ProjectTest.c,25 :: 		int PIR = 0;
;ProjectTest.c,26 :: 		int CO = 0;
;ProjectTest.c,27 :: 		ADCSRA|=(1<<ADSC);
	IN         R27, ADCSRA+0
	SBR        R27, 64
	OUT        ADCSRA+0, R27
;ProjectTest.c,28 :: 		while((ADCSRA&(1<<ADIF))==0);
L_main5:
	IN         R16, ADCSRA+0
	ANDI       R16, 16
	CPI        R16, 0
	BREQ       L__main22
	JMP        L_main6
L__main22:
	JMP        L_main5
L_main6:
;ProjectTest.c,29 :: 		PORTD =ADCL;
	IN         R16, ADCL+0
	OUT        PORTD+0, R16
;ProjectTest.c,30 :: 		PORTB =ADCH;
	IN         R16, ADCH+0
	OUT        PORTB+0, R16
;ProjectTest.c,31 :: 		if(PORTD >= 0x81 ){ tmp = 1;  }
	IN         R16, PORTD+0
	CPI        R16, 129
	BRSH       L__main23
	JMP        L_main7
L__main23:
	LDI        R27, 1
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
L_main7:
;ProjectTest.c,32 :: 		if(PINA == 0x01 ){ CO =1  ;   }
	IN         R16, PINA+0
	CPI        R16, 1
	BREQ       L__main24
	JMP        L_main8
L__main24:
	LDI        R27, 1
	STD        Y+4, R27
	LDI        R27, 0
	STD        Y+5, R27
L_main8:
;ProjectTest.c,33 :: 		if(PINA == 0x02 ){ PIR =1;   }
	IN         R16, PINA+0
	CPI        R16, 2
	BREQ       L__main25
	JMP        L_main9
L__main25:
	LDI        R27, 1
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
L_main9:
;ProjectTest.c,34 :: 		if(PINA == 0x03 ){ CO =1; PIR =1;   }
	IN         R16, PINA+0
	CPI        R16, 3
	BREQ       L__main26
	JMP        L_main10
L__main26:
	LDI        R27, 1
	STD        Y+4, R27
	LDI        R27, 0
	STD        Y+5, R27
	LDI        R27, 1
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
L_main10:
;ProjectTest.c,35 :: 		if  (tmp+CO+PIR > 0 && count < 100)
	LDD        R18, Y+0
	LDD        R19, Y+1
	LDD        R16, Y+4
	LDD        R17, Y+5
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+2
	LDD        R17, Y+3
	ADD        R18, R16
	ADC        R19, R17
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main27
	JMP        L__main19
L__main27:
	LDS        R18, _count+0
	LDS        R19, _count+1
	LDI        R16, 100
	LDI        R17, 0
	CP         R18, R16
	CPC        R19, R17
	BRLT       L__main28
	JMP        L__main18
L__main28:
L__main17:
;ProjectTest.c,37 :: 		if(PIR)          PORTE=0x0D;
	LDD        R16, Y+2
	LDD        R17, Y+3
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__main29
	JMP        L_main14
L__main29:
	LDI        R27, 13
	OUT        PORTE+0, R27
	JMP        L_main15
L_main14:
;ProjectTest.c,38 :: 		else             PORTE=0x05;
	LDI        R27, 5
	OUT        PORTE+0, R27
L_main15:
;ProjectTest.c,39 :: 		count++;
	LDS        R16, _count+0
	LDS        R17, _count+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _count+0, R16
	STS        _count+1, R17
;ProjectTest.c,40 :: 		}
	JMP        L_main16
;ProjectTest.c,35 :: 		if  (tmp+CO+PIR > 0 && count < 100)
L__main19:
L__main18:
;ProjectTest.c,43 :: 		PORTE = 0x00;
	LDI        R27, 0
	OUT        PORTE+0, R27
;ProjectTest.c,44 :: 		}
L_main16:
;ProjectTest.c,45 :: 		}
L_main4:
;ProjectTest.c,46 :: 		PORTC = count;
	LDS        R16, _count+0
	OUT        PORTC+0, R16
;ProjectTest.c,47 :: 		}
	JMP        L_main0
;ProjectTest.c,49 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
