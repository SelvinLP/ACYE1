#include <Servo.h>
#include "Arduino.h"
Servo myservo;  
int pos = 0;   
int vel = 10;

void setup_sweeper() {
  myservo.attach(11); 
  myservo.write(0);
}

void stop_sweep(){
  myservo.write(0);
}

void sweep(){
  for (pos = 0; pos <= 360; pos += vel ) { 
    myservo.write(pos/7);              
    delay(10);               
  }
  Serial.println("1ra vuelta");
  delay(1000);
  
  for (pos = 360; pos <= 720; pos += vel ) { 
    myservo.write(pos/7);              
    delay(10);               
  }
  Serial.println("2da vuelta");
  delay(1000);
  
   for (pos = 720; pos <= 1080; pos += vel ) { 
    myservo.write(pos/7);              
    delay(10);               
  }
  Serial.println("3ra vuelta");
  delay(1000);
  
   for (pos = 1080; pos <= 1260; pos += vel ) { 
    myservo.write(pos/7);              
    delay(10);               
  }
  Serial.println("3ra vuelta y media");
  delay(1000);
  stop_sweep();
  delay(5000);
}
