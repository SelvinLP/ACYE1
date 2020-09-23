#include "Arduino.h"
#include "Servo.h"  
#include "turtle.h" 


//cabeza
Servo Head;


//------------------------SENSOR ULTRASONICO-------------
const int Trigger = 22; //pin digital 2 para el Trigger del sensor
const int Echo = 23; //Pin digital 3 para el Echo del sensor
//-----------------------------------------------------------


void setup_sonic(){
//------------------------SENSOR ULTRASONICO-------------
Serial.begin(9600); //inicializamos la comunicacion
pinMode(Trigger,OUTPUT); //pin como salida
pinMode(Echo,INPUT); //pin como entrada
digitalWrite(Trigger,LOW); //inicializamos el pin con 22
Head.attach(24);
Head.write(90);
//-----------------------------------------------------
}

void sensor_sonic(){
  //------------------------SENSOR ULTRASONICO-------------
long t;
long d;

digitalWrite(Trigger, HIGH);
delayMicroseconds(10);
digitalWrite(Trigger,LOW);

t = pulseIn(Echo, HIGH,5000);
d = (t*100)/5882;

Serial.print("Distancia: ");
Serial.print(d); //la distancia que esta retornando el sensor
Serial.print("cm");
Serial.println();

if( d > 1 || d == 0){//se mueve el carrito
   movimiento_turtle();
}else{//se detiene porque hay objeto
  Serial.println("OBSTACULO AL FRENTE!!");
  movimiento_pared();  
  
 //delay(5000);
}




delay(1);


//------------------------------------------------------------
}
