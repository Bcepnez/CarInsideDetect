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
                int x;
                int tmp = 0;
                int PIR = 0;
                int CO = 0;
                ADCSRA|=(1<<ADSC);
                while((ADCSRA&(1<<ADIF))==0);
                PORTD =ADCL;
                PORTB =ADCH;
                if(PORTD >= 0x95  ){ tmp = 1;  }
                if(PINA & 0x01 ){ CO =1  ;   }
                if(PINA & 0x02 ){ PIR =1;   }
                if  (tmp+CO+PIR > 0 && !(PINA&0x10))
                {
                    x=0x04;
                    if(count < 1000) {
                         x|=0x01;
                         count++;
                    }
                    else {
                         x&=0x0C;
                    }
                    if(PIR && !(PINA&0x10)) x|=0x0C;
                    else x&=0x07;
                    PORTE=x;
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