#include "Servo.h"     
#include "Arduino.h"
#include "Turtle.h"
#include "matriz.h"
#include "stepper.h"

//Llantas
#define LlantaIAdel 2
#define LlantaIRest 3
#define LlantaDAdel 4
#define LlantaDRest 5

//Definicion de Sensores
#define SensorI 8
#define SensorC 9
#define SensorD 10

//Velocidad o fuente
#define PwI 6
#define PwD 7

//tiempo matriz
int tiempo=0;

//VARIABLES
int Fuera_Limite=0;
int Estabilizar=0;
//Matriz
int Tomar_vuelta=0;
void setup_turtle() {
  //Llantas
  pinMode(LlantaIAdel,OUTPUT);
  pinMode(LlantaIRest,OUTPUT);
  pinMode(LlantaDAdel,OUTPUT);
  pinMode(LlantaDRest,OUTPUT);
  //
  pinMode(PwI,OUTPUT);
  pinMode(PwD,OUTPUT);
  //Sensores
  pinMode(SensorI,INPUT);
  pinMode(SensorC,INPUT);
  pinMode(SensorD,INPUT);
  
}
void movimiento_turtle() {
    //validamos el tiempo
    tiempo+=1;
    //Obtenemos los valores de los sensores
    int Sensor1=digitalRead(SensorI);
    int Sensor2=digitalRead(SensorC);
    int Sensor3=digitalRead(SensorD);

    if( Sensor1==LOW && Sensor2==LOW && Sensor3==LOW){//Giro de 180 grados para regresar a la linea
            analogWrite(PwI,75);//El 100 representa la velocidad
            analogWrite(PwD,75);
            //Llanta Izquierda
            Serial.println("Se salio del camino");
            digitalWrite(LlantaIAdel,HIGH);
            digitalWrite(LlantaIRest,LOW);
            //Llanta Izquierda
            digitalWrite(LlantaDAdel,HIGH);
            digitalWrite(LlantaDRest,LOW);
            delay(2880);
            digitalWrite(LlantaIAdel,LOW);
            digitalWrite(LlantaIRest,HIGH);
            //Llanta Izquierda
            digitalWrite(LlantaDAdel,HIGH);
            digitalWrite(LlantaDRest,LOW);
            delay(100);
    }

    
    if( Sensor1==LOW && Sensor2==HIGH && Sensor3==LOW){//avanza hacia adelante
  
        analogWrite(PwI,75);//El 75 representa la velocidad
        analogWrite(PwD,75);
        //Llanta Izquierda
        digitalWrite(LlantaIAdel,LOW);
        digitalWrite(LlantaIRest,HIGH);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);
        delay(100);
        //Impresion de matriz
        if(tiempo>20){cambio(0); tiempo=0;}
        //Movimiento de Ruedas
        movimiento_ruedaI();
        movimiento_ruedaD();
    }


    if (Sensor1==HIGH && Sensor2==HIGH && Sensor3==HIGH){//encuentra linea y se incorpora a ella
        analogWrite(PwI,75);
        analogWrite(PwD,75);
        //Llanta Izquierda
        digitalWrite(LlantaIAdel,LOW);
        digitalWrite(LlantaIRest,HIGH);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);
        delay(60);
        Serial.println("Giro a la izquierda");
        //Llanta Izquierda
        digitalWrite(LlantaIAdel,HIGH); 
        digitalWrite(LlantaIRest,LOW);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);
        delay(1440);
        //Llanta Izquierda
        Serial.println("avanza...");
        digitalWrite(LlantaIAdel,LOW);
        digitalWrite(LlantaIRest,HIGH);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);
        delay(300);

    }

    
    if(Sensor1==HIGH && Sensor2==HIGH && Sensor3==LOW ){//gira hacia la izquierda
        
        analogWrite(PwI,75);
        analogWrite(PwD,75);
        //Llanta Izquierda
        digitalWrite(LlantaIAdel,LOW);
        digitalWrite(LlantaIRest,HIGH);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);
        delay(60);//add
        Serial.println("Giro a la izquierda");
        //Llanta Izquierda
        digitalWrite(LlantaIAdel,HIGH);
        digitalWrite(LlantaIRest,LOW);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);

        //Movmimiento de la rueda y delay
        for(int pos=0;pos<8;pos++){
          //Movimiento de Ruedas
          movimiento_ruedaD();
          delay(180);
        }
        
        //Llanta Izquierda
        Serial.println("avanza...");
        digitalWrite(LlantaIAdel,LOW);//change
        digitalWrite(LlantaIRest,HIGH);//change
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);//change
        digitalWrite(LlantaDRest,LOW);//change
        delay(300);

        //Impresion de matriz
        cambio(1); tiempo=0;
        
    }

    if(Sensor1==LOW && Sensor2==HIGH && Sensor3==HIGH){//gira hacia la derecha
        
        analogWrite(PwI,75);
        analogWrite(PwD,75);
        //Llanta Izquierda
        digitalWrite(LlantaIAdel,LOW);
        digitalWrite(LlantaIRest,HIGH);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);
        delay(60);//add
        Serial.println("Giro a la derecha");
        //Llanta Izquierda
        digitalWrite(LlantaIAdel,LOW);
        digitalWrite(LlantaIRest,HIGH);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,LOW);
        digitalWrite(LlantaDRest,HIGH);
        //Movmimiento de la rueda y delay
        for(int pos=0;pos<8;pos++){
          //Movimiento de Ruedas
          movimiento_ruedaI();
          delay(180);
        }
        //Llanta Izquierda
        Serial.println("avanza...");
        digitalWrite(LlantaIAdel,LOW);
        digitalWrite(LlantaIRest,HIGH);
        //Llanta Izquierda
        digitalWrite(LlantaDAdel,HIGH);
        digitalWrite(LlantaDRest,LOW);
        delay(300);

        //Impresion de matriz
        cambio(2); tiempo=0;
        //Movimiento de Ruedas
        movimiento_ruedaI();
    }
   
}


void movimiento_pared(){//pared encontrada

    Serial.println("Pared encontrada.... evadiendo obstaculo!!");

    //Obtenemos los valores de los sensores
    int Sensor1=digitalRead(SensorI);
    int Sensor2=digitalRead(SensorC);
    int Sensor3=digitalRead(SensorD);

    analogWrite(PwI,75);//El 75 representa la velocidad
    analogWrite(PwD,75);

     //Llanta Izquierda
    digitalWrite(LlantaIAdel,LOW);
    digitalWrite(LlantaIRest,HIGH);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,HIGH);
    digitalWrite(LlantaDRest,LOW);
    delay(400);//add
    
    //SE GIRA A LA DERECHA
    //Llanta Izquierda
    digitalWrite(LlantaIAdel,LOW);
    digitalWrite(LlantaIRest,HIGH);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,LOW);
    digitalWrite(LlantaDRest,HIGH);
    //Movmimiento de la rueda y delay
    for(int pos=0;pos<8;pos++){
      //Movimiento de Ruedas
      movimiento_ruedaI();
      delay(180);
    }
    
    //SE AVANZA
    //Llanta Izquierda
    digitalWrite(LlantaIAdel,LOW);
    digitalWrite(LlantaIRest,HIGH);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,HIGH);
    digitalWrite(LlantaDRest,LOW);
    for(int pos=0;pos<18;pos++){
      //Movimiento de Ruedas
      movimiento_ruedaD();
      movimiento_ruedaI();
      delay(150);
    }
    //Imprimimos en matriz
    cambio(2); tiempo=0;

    //SE GIRA A LA IZQUIERDA
    //Llanta Izquierda
    digitalWrite(LlantaIAdel,HIGH);
    digitalWrite(LlantaIRest,LOW);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,HIGH);
    digitalWrite(LlantaDRest,LOW);
    for(int pos=0;pos<8;pos++){
      //Movimiento de Ruedas
      movimiento_ruedaD();
      delay(180);
    }

    //SE AVANZA
    //Llanta Izquierda
    digitalWrite(LlantaIAdel,LOW);
    digitalWrite(LlantaIRest,HIGH);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,HIGH);
    digitalWrite(LlantaDRest,LOW);
    for(int pos=0;pos<30;pos++){
      //Movimiento de Ruedas
      movimiento_ruedaD();
      movimiento_ruedaI();
      delay(150);
    }
    //Imprimimos en matriz
    cambio(1); tiempo=0;

    //SE GIRA A LA IZQUIERDA
    //Llanta Izquierda
    digitalWrite(LlantaIAdel,HIGH);
    digitalWrite(LlantaIRest,LOW);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,HIGH);
    digitalWrite(LlantaDRest,LOW);
    for(int pos=0;pos<8;pos++){
      //Movimiento de Ruedas
      movimiento_ruedaD();
      delay(180);
    }

    //SE AVANZA
    //Llanta Izquierda
    digitalWrite(LlantaIAdel,LOW);
    digitalWrite(LlantaIRest,HIGH);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,HIGH);
    digitalWrite(LlantaDRest,LOW);
    for(int pos=0;pos<18;pos++){
      //Movimiento de Ruedas
      movimiento_ruedaD();
      movimiento_ruedaI();
      delay(150);
    }
    //Imprimimos en matriz
    cambio(1); tiempo=0;

    //SE GIRA A LA DERECHA
    //Llanta Izquierda
    digitalWrite(LlantaIAdel,LOW);
    digitalWrite(LlantaIRest,HIGH);
    //Llanta Izquierda
    digitalWrite(LlantaDAdel,LOW);
    digitalWrite(LlantaDRest,HIGH);
    //Movmimiento de la rueda y delay
    for(int pos=0;pos<8;pos++){
      //Movimiento de Ruedas
      movimiento_ruedaI();
      delay(180);
    }
    //Imprimimos en matriz
    cambio(2); tiempo=0;
}

void stop_turtle(){
  digitalWrite(LlantaIAdel,LOW);
  digitalWrite(LlantaIRest,LOW);
  digitalWrite(LlantaDAdel,LOW);
  digitalWrite(LlantaDRest,LOW);
}
