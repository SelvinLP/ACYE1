#include "Arduino.h"
#include "LcdDisplay.h"
#include "Buzzer.h"

#define motor1_l1 11
#define motor2_l1 10
#define motor3_l1 9
#define motor4_l1 6

#define motor1_l2 15
#define motor2_l2 16
#define motor3_l2 17
#define motor4_l2 3

#define flag_l1 22
#define flag_l2 23

#define vel 500

void setup_conveyor_bar(){

  pinMode( motor1_l1, OUTPUT );
  pinMode( motor2_l1, OUTPUT );
  pinMode( motor3_l1, OUTPUT );
  pinMode( motor4_l1, OUTPUT );

  pinMode( motor1_l2, OUTPUT );
  pinMode( motor2_l2, OUTPUT );
  pinMode( motor3_l2, OUTPUT );
  pinMode( motor4_l2, OUTPUT );
 
  pinMode( flag_l1, INPUT );
  pinMode( flag_l2, INPUT );
}

void motor_to_right(){
  if ( digitalRead(flag_l1) == 0 ){
    print_text("Poner Muestra", 0);
    print_text("en la banda LAB1", 1);
    delay(3000);
    clear_screen();
    return;
  }
  else if ( digitalRead(flag_l2) == 1 and digitalRead(flag_l1) == 1 ){
    print_text("ERROR 2 MUESTRAS", 0);
    print_text("SOBRE LA BANDA", 1);
    delay(2000);
    clear_screen();
    return;
  }
  
  print_text("Corriendo hacia", 0);
  print_text("la Derecha", 1);
  
  /*BUZZER ....................................................... POR 3s.*/
  Activate_Buzzer(2);
  /*****************************************************************/
    
  while ( digitalRead(flag_l1) == 1 and digitalRead(flag_l2) == 0 ){
    digitalWrite(motor1_l1,HIGH); digitalWrite(motor2_l1,LOW); digitalWrite(motor3_l1,LOW); digitalWrite(motor4_l1,LOW);
    digitalWrite(motor1_l2,HIGH); digitalWrite(motor2_l2,LOW); digitalWrite(motor3_l2,LOW); digitalWrite(motor4_l2,LOW);
    delay(vel);
    digitalWrite(motor1_l1,LOW); digitalWrite(motor2_l1,HIGH); digitalWrite(motor3_l1,LOW); digitalWrite(motor4_l1,LOW);
    digitalWrite(motor1_l2,LOW); digitalWrite(motor2_l2,HIGH); digitalWrite(motor3_l2,LOW); digitalWrite(motor4_l2,LOW);
    delay(vel);
    digitalWrite(motor1_l1,LOW); digitalWrite(motor2_l1,LOW); digitalWrite(motor3_l1,HIGH); digitalWrite(motor4_l1,LOW);
    digitalWrite(motor1_l2,LOW); digitalWrite(motor2_l2,LOW); digitalWrite(motor3_l2,HIGH); digitalWrite(motor4_l2,LOW);
    delay(vel);
    digitalWrite(motor1_l1, LOW ); digitalWrite(motor2_l1, LOW); digitalWrite(motor3_l1, LOW); digitalWrite(motor4_l1, HIGH);
    digitalWrite(motor1_l2, LOW ); digitalWrite(motor2_l2, LOW); digitalWrite(motor3_l2, LOW); digitalWrite(motor4_l2, HIGH);
    delay(vel); 
  }

  /*BUZZER ....................................................... POR 1s.*/
   Activate_Buzzer(3);
  /*****************************************************************/
  
  clear_screen();
  print_text("La Muestra llego", 0);
  print_text("al LAB 2!", 1);
  delay(3000);
  clear_screen();
  
}
void motor_to_left(){
  if ( digitalRead(flag_l2) == 0 ){
    print_text("Poner Muestra", 0);
    print_text("en la banda LAB2", 1);
    delay(3000);
    clear_screen();
    return;
  }
  else if ( digitalRead(flag_l2) == 1 and digitalRead(flag_l1) == 1 ){
    print_text("ERROR 2 MUESTRAS", 0);
    print_text("SOBRE LA BANDA", 1);
    delay(2000);
    clear_screen();
    return;
  }
  
  print_text("Corriendo hacia", 0);
  print_text("la Izquierda", 1);
 
  
  /*BUZZER ....................................................... POR 3s.*/
  Activate_Buzzer(2);
  /*****************************************************************/
  
  
  while ( digitalRead(flag_l2) == 1 and digitalRead(flag_l1) == 0 ){
    digitalWrite(motor1_l1, LOW ); digitalWrite(motor2_l1, LOW); digitalWrite(motor3_l1, LOW); digitalWrite(motor4_l1, HIGH);
    digitalWrite(motor1_l2, LOW ); digitalWrite(motor2_l2, LOW); digitalWrite(motor3_l2, LOW); digitalWrite(motor4_l2, HIGH);
    delay(vel); 
    digitalWrite(motor1_l1,LOW); digitalWrite(motor2_l1,LOW); digitalWrite(motor3_l1,HIGH); digitalWrite(motor4_l1,LOW);
    digitalWrite(motor1_l2,LOW); digitalWrite(motor2_l2,LOW); digitalWrite(motor3_l2,HIGH); digitalWrite(motor4_l2,LOW);
    delay(vel);
    digitalWrite(motor1_l1,LOW); digitalWrite(motor2_l1,HIGH); digitalWrite(motor3_l1,LOW); digitalWrite(motor4_l1,LOW);
    digitalWrite(motor1_l2,LOW); digitalWrite(motor2_l2,HIGH); digitalWrite(motor3_l2,LOW); digitalWrite(motor4_l2,LOW);
    delay(vel);
    digitalWrite(motor1_l1,HIGH); digitalWrite(motor2_l1,LOW); digitalWrite(motor3_l1,LOW); digitalWrite(motor4_l1,LOW);
    digitalWrite(motor1_l2,HIGH); digitalWrite(motor2_l2,LOW); digitalWrite(motor3_l2,LOW); digitalWrite(motor4_l2,LOW);
    delay(vel);
  }

  /*BUZZER ....................................................... POR 1s.*/
     Activate_Buzzer(6);
  /*****************************************************************/
  
  
  clear_screen();
  print_text("La Muestra llego", 0);
  print_text("al LAB 1!", 1);
  delay(3000);
  clear_screen();
  
}

void stop_motor(){
  digitalWrite(motor1_l1,LOW); digitalWrite(motor2_l1,LOW); digitalWrite(motor3_l1,LOW); digitalWrite(motor4_l1,LOW);
  digitalWrite(motor1_l2,LOW); digitalWrite(motor2_l2,LOW); digitalWrite(motor3_l2,LOW); digitalWrite(motor4_l2,LOW);
 
}
