#include "Arduino.h"
#include "LcdDisplay.h"
#include <Servo.h>
#include "Buzzer.h"

#define gate_open 4
#define gate_close 14
#define gate_servo 5

int pos = 0;   
int vel = 5;
Servo my_servo;  

void setup_gate(){
   pinMode(gate_open, OUTPUT);
   pinMode(gate_close, OUTPUT);

  my_servo.attach( gate_servo );
  my_servo.write(0);
}

String verificar(){
  String op = "";
  while ( Serial.available() ) {
    delay( 10 );
    char ch = Serial.read();
    op += ch;
  }
  return op;
}

void close_the_gate(){
   clear_screen();
  print_gate_close();
  my_servo.write( 0 );
  delay(2000);
  digitalWrite( gate_open, LOW );
  digitalWrite( gate_close, HIGH );
  clear_screen();
  delay(2000);
  Activate_Buzzer(5); /////SE ACTIVA EL BUZZER POR 3 SEGUNDOS
  digitalWrite( gate_close, LOW );
  clear_screen();
}

void open_the_gate(){
  
   print_gate_open();
   for (pos = 0; pos <= 720; pos += vel ) { 
    my_servo.write(pos/4);              
    delay(10);               
  }
  delay(1000);
  digitalWrite( gate_open, HIGH );
  bool cerrar = true;
  for (int i = 0; i < 12 ; i += 1 ) {
    String flag = verificar();
    if ( flag.equals("P_Close") ){
      close_the_gate();
      cerrar = false; 
      break;
    }
    delay(500);              
  }

  if (cerrar == true){
    close_the_gate();
  }
  
}
