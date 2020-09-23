#include "Arduino.h"

int EstadoRuedaI=0;
int EstadoRuedaD=0;
void setup_stepper() {
  //Rueda Izquierda
  pinMode(49,OUTPUT);
  pinMode(47,OUTPUT);
  pinMode(43,OUTPUT);
  pinMode(41,OUTPUT);
  //Rueda Derecha
  pinMode(39,OUTPUT);
  pinMode(37,OUTPUT);
  pinMode(33,OUTPUT);
  pinMode(31,OUTPUT);
}
void movimiento_ruedaI(){
  //myStepper.step(stepsPerRevolution);
  if(EstadoRuedaI==0){
    digitalWrite(49,HIGH);
    digitalWrite(43,LOW);
    digitalWrite(47,LOW);
    digitalWrite(41,LOW);
  }
  else if(EstadoRuedaI==1){
    digitalWrite(49,LOW);
    digitalWrite(43,HIGH);
    digitalWrite(47,LOW);
    digitalWrite(41,LOW);
  }
  else if(EstadoRuedaI==2){
    digitalWrite(49,LOW);
    digitalWrite(43,LOW);
    digitalWrite(47,HIGH);
    digitalWrite(41,LOW);
  }
  else if(EstadoRuedaI==3){
    digitalWrite(49,LOW);
    digitalWrite(43,LOW);
    digitalWrite(47,LOW);
    digitalWrite(41,HIGH);
    EstadoRuedaI=-1;
  }
  EstadoRuedaI++;
}
void movimiento_ruedaD(){
  //myStepper.step(stepsPerRevolution);
  if(EstadoRuedaD==0){
    digitalWrite(39,HIGH);
    digitalWrite(33,LOW);
    digitalWrite(37,LOW);
    digitalWrite(31,LOW);
  }
  else if(EstadoRuedaD==1){
    digitalWrite(39,LOW);
    digitalWrite(33,HIGH);
    digitalWrite(37,LOW);
    digitalWrite(31,LOW);
  }
  else if(EstadoRuedaD==2){
    digitalWrite(39,LOW);
    digitalWrite(33,LOW);
    digitalWrite(37,HIGH);
    digitalWrite(31,LOW);
  }
  else if(EstadoRuedaD==3){
    digitalWrite(39,LOW);
    digitalWrite(33,LOW);
    digitalWrite(37,LOW);
    digitalWrite(31,HIGH);
    EstadoRuedaD=-1;
  }
  EstadoRuedaD++;
}

void stop_stepper(){
  digitalWrite(49,LOW);
  digitalWrite(43,LOW);
  digitalWrite(47,LOW);
  digitalWrite(41,LOW);

  digitalWrite(39,LOW);
  digitalWrite(33,LOW);
  digitalWrite(37,LOW);
  digitalWrite(31,LOW);
}
