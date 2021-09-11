#include <avr/io.h>
#include <util/delay.h>

#define Fosc 16000000
#define USART_BAUDRATE 9600
#define BAUD_PRESCALE (((Fosc / (USART_BAUDRATE * 16UL))) - 1) //type constant


void usart_init(){

   UCSR0B = (1 << RXEN0) | (1 << TXEN0);   // Turn on the transmission and reception circuit
   UCSR0C = (0 << UPM00) |(0 << UPM01) |(0 << USBS0) |(1 << UCSZ00) | (1 << UCSZ01); // Use 8-bit character sizes
  //no parity, 1 stop bit
   UBRR0H = ( BAUD_PRESCALE>>8); // Load upper 8-bits of the baud rate value into the high byte of the UBRR register
   UBRR0L = BAUD_PRESCALE; // Load lower 8-bits of the baud rate value into the low byte of the UBRR register

}



void usart_send(char ch)
{
  while ((UCSR0A & (1 << UDRE0)) == 0); // Do nothing until UDR is ready for more data to be written to it
  UDR0 = ch; // Echo back the received byte back to the computer
}

char usart_receive()
{
  while ((UCSR0A & (1 << RXC0)) == 0) ; // Do nothing until data have been received and is ready to be read from UDR
    return (UDR0); // Fetch the received byte value into the variable "ByteReceived"

}




void usart_sendStr(char * ch){
    int i = 0;

    for (i = 0; ch[i]!='\0'; i++){
              
           while (( UCSR0A & (1<<UDRE0))  == 0);// Do nothing until UDR is ready for more data to be written to it
           UDR0 = ch[i];
   
    }
}
int main(void){
	//declare input ports

	//declare output ports



	return 0;
}