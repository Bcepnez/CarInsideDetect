int count=0;
int main(void)
{
   DDRB = 0xFF;
   DDRA = 0;
   DDRD = 0xFF;
   DDRE = 0xFF;
   DDRC = 0xFF;
   ADCSRA = 0x87;
   ADMUX = 0xC0;

   while(1)
   {
           if(PINA&0x10)
           {
                   if(count>0){
                          PORTE=0x02;
                          count--;
                   }
                   PORTE=0x00;
                   //count = 0 ;
           }
           else{
                int tmp = 0;
                int PIR = 0;
                int CO = 0;
                ADCSRA|=(1<<ADSC);
                while((ADCSRA&(1<<ADIF))==0);
                PORTD =ADCL;
                PORTB =ADCH;
                if(PORTD >= 0x81 ){ tmp = 1;  }
                if(PINA == 0x01 ){ CO =1  ;   }
                if(PINA == 0x02 ){ PIR =1;   }
                if(PINA == 0x03 ){ CO =1; PIR =1;   }
                if  (tmp+CO+PIR > 0 && count < 100)
                {
                    if(PIR)          PORTE=0x0D;
                    else             PORTE=0x05;
                    count++;
                }
                else
                {
                    PORTE = 0x00;
                }
           }
           PORTC = count;
   }
   return 0;
}