#include "matriz.h"
#include "turtle.h"
#include "sonic.h"
#include "stepper.h"
#include "sweeper.h"

bool flag = false;
void setup() {
  // put your setup code here, to run once:
//  Serial.begin(9600);
  setup_matriz();
  setup_turtle();
  setup_sonic();
  setup_stepper();
  setup_sweeper();

  attachInterrupt( digitalPinToInterrupt(20), changeFlag, LOW );
}

void loop() {
  // put your main code here, to run repeatedly:
  if (!flag)
    sensor_sonic();
  else{
    int sensorValue = analogRead(A0);
    if (sensorValue >= 36 && sensorValue <= 42  ){
      Serial.println("The color is Yellow");
      sweep();
    } else {
      stop_sweep();
    }
  }
}

void changeFlag(){
  if (flag){
    movimiento_turtle();
    flag = false; 
  }
  else{
    stop_turtle();
    stop_stepper();
    flag = true;
  }
    
}
