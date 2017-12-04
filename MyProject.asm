
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 8
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;MyProject.c,2 :: 		int main(void)
;MyProject.c,4 :: 		DDRB = 0xFF;
	LDI        R27, 255
	OUT        DDRB+0, R27
;MyProject.c,5 :: 		DDRA = 0;
	LDI        R27, 0
	OUT        DDRA+0, R27
;MyProject.c,6 :: 		DDRD = 0xFF;
	LDI        R27, 255
	OUT        DDRD+0, R27
;MyProject.c,7 :: 		DDRE = 0xFF;
	LDI        R27, 255
	OUT        DDRE+0, R27
;MyProject.c,8 :: 		DDRC = 0xFF;
	LDI        R27, 255
	OUT        DDRC+0, R27
;MyProject.c,9 :: 		ADCSRA = 0x87;
	LDI        R27, 135
	OUT        ADCSRA+0, R27
;MyProject.c,10 :: 		ADMUX = 0xC0;
	LDI        R27, 192
	OUT        ADMUX+0, R27
;MyProject.c,12 :: 		while(1)
L_main0:
;MyProject.c,14 :: 		if(PINA&0x10)
	IN         R16, PINA+0
	SBRS       R16, 4
	JMP        L_main2
;MyProject.c,16 :: 		if(count>0){
	LDS        R18, _count+0
	LDS        R19, _count+1
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main28
	JMP        L_main3
L__main28:
;MyProject.c,17 :: 		PORTE=0x02;
	LDI        R27, 2
	OUT        PORTE+0, R27
;MyProject.c,18 :: 		count--;
	LDS        R16, _count+0
	LDS        R17, _count+1
	SUBI       R16, 1
	SBCI       R17, 0
	STS        _count+0, R16
	STS        _count+1, R17
;MyProject.c,19 :: 		}
L_main3:
;MyProject.c,20 :: 		PORTE=0x00;
	LDI        R27, 0
	OUT        PORTE+0, R27
;MyProject.c,22 :: 		}
	JMP        L_main4
L_main2:
;MyProject.c,25 :: 		int tmp = 0;
	LDI        R27, 0
	STD        Y+2, R27
	STD        Y+3, R27
	LDI        R27, 0
	STD        Y+4, R27
	STD        Y+5, R27
	LDI        R27, 0
	STD        Y+6, R27
	STD        Y+7, R27
;MyProject.c,26 :: 		int PIR = 0;
;MyProject.c,27 :: 		int CO = 0;
;MyProject.c,28 :: 		ADCSRA|=(1<<ADSC);
	IN         R27, ADCSRA+0
	SBR        R27, 64
	OUT        ADCSRA+0, R27
;MyProject.c,29 :: 		while((ADCSRA&(1<<ADIF))==0);
L_main5:
	IN         R16, ADCSRA+0
	ANDI       R16, 16
	CPI        R16, 0
	BREQ       L__main29
	JMP        L_main6
L__main29:
	JMP        L_main5
L_main6:
;MyProject.c,30 :: 		PORTD =ADCL;
	IN         R16, ADCL+0
	OUT        PORTD+0, R16
;MyProject.c,31 :: 		PORTB =ADCH;
	IN         R16, ADCH+0
	OUT        PORTB+0, R16
;MyProject.c,32 :: 		if(PORTD >= 0x81 ){ tmp = 1;  }
	IN         R16, PORTD+0
	CPI        R16, 129
	BRSH       L__main30
	JMP        L_main7
L__main30:
	LDI        R27, 1
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
L_main7:
;MyProject.c,33 :: 		if(PINA == 0x01 ){ CO =1  ;   }
	IN         R16, PINA+0
	CPI        R16, 1
	BREQ       L__main31
	JMP        L_main8
L__main31:
	LDI        R27, 1
	STD        Y+6, R27
	LDI        R27, 0
	STD        Y+7, R27
L_main8:
;MyProject.c,34 :: 		if(PINA == 0x02 ){ PIR =1;   }
	IN         R16, PINA+0
	CPI        R16, 2
	BREQ       L__main32
	JMP        L_main9
L__main32:
	LDI        R27, 1
	STD        Y+4, R27
	LDI        R27, 0
	STD        Y+5, R27
L_main9:
;MyProject.c,35 :: 		if(PINA == 0x03 ){ CO =1; PIR =1;   }
	IN         R16, PINA+0
	CPI        R16, 3
	BREQ       L__main33
	JMP        L_main10
L__main33:
	LDI        R27, 1
	STD        Y+6, R27
	LDI        R27, 0
	STD        Y+7, R27
	LDI        R27, 1
	STD        Y+4, R27
	LDI        R27, 0
	STD        Y+5, R27
L_main10:
;MyProject.c,36 :: 		if  (tmp+CO+PIR > 0 && !(PINA&0x10))
	LDD        R18, Y+2
	LDD        R19, Y+3
	LDD        R16, Y+6
	LDD        R17, Y+7
	ADD        R18, R16
	ADC        R19, R17
	LDD        R16, Y+4
	LDD        R17, Y+5
	ADD        R18, R16
	ADC        R19, R17
	LDI        R16, 0
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main34
	JMP        L__main26
L__main34:
	IN         R16, PINA+0
	SBRC       R16, 4
	JMP        L__main25
L__main22:
;MyProject.c,38 :: 		x=0x04;
	LDI        R27, 4
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
;MyProject.c,39 :: 		if(count < 1000) {
	LDS        R18, _count+0
	LDS        R19, _count+1
	LDI        R16, 232
	LDI        R17, 3
	CP         R18, R16
	CPC        R19, R17
	BRLT       L__main35
	JMP        L_main14
L__main35:
;MyProject.c,40 :: 		x|=0x01;
	LDD        R16, Y+0
	LDD        R17, Y+1
	ORI        R16, 1
	ORI        R17, 0
	STD        Y+0, R16
	STD        Y+1, R17
;MyProject.c,41 :: 		count++;
	LDS        R16, _count+0
	LDS        R17, _count+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _count+0, R16
	STS        _count+1, R17
;MyProject.c,42 :: 		}
	JMP        L_main15
L_main14:
;MyProject.c,44 :: 		x&=0x0C;
	LDD        R16, Y+0
	LDD        R17, Y+1
	ANDI       R16, 12
	ANDI       R17, 0
	STD        Y+0, R16
	STD        Y+1, R17
;MyProject.c,45 :: 		}
L_main15:
;MyProject.c,46 :: 		if(PIR && !(PINA&0x10)) x|=0x0C;
	LDD        R16, Y+4
	LDD        R17, Y+5
	MOV        R27, R16
	OR         R27, R17
	BRNE       L__main36
	JMP        L__main24
L__main36:
	IN         R16, PINA+0
	SBRC       R16, 4
	JMP        L__main23
L__main21:
	LDD        R16, Y+0
	LDD        R17, Y+1
	ORI        R16, 12
	ORI        R17, 0
	STD        Y+0, R16
	STD        Y+1, R17
	JMP        L_main19
L__main24:
L__main23:
;MyProject.c,47 :: 		else x&=0x07;
	LDD        R16, Y+0
	LDD        R17, Y+1
	ANDI       R16, 7
	ANDI       R17, 0
	STD        Y+0, R16
	STD        Y+1, R17
L_main19:
;MyProject.c,48 :: 		PORTE=x;
	LDD        R16, Y+0
	OUT        PORTE+0, R16
;MyProject.c,49 :: 		}
	JMP        L_main20
;MyProject.c,36 :: 		if  (tmp+CO+PIR > 0 && !(PINA&0x10))
L__main26:
L__main25:
;MyProject.c,52 :: 		PORTE = 0x00;
	LDI        R27, 0
	OUT        PORTE+0, R27
;MyProject.c,53 :: 		}
L_main20:
;MyProject.c,54 :: 		}
L_main4:
;MyProject.c,55 :: 		PORTC = count;
	LDS        R16, _count+0
	OUT        PORTC+0, R16
;MyProject.c,56 :: 		}
	JMP        L_main0
;MyProject.c,58 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
