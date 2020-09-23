#include "Arduino.h"

#define light_entrence 13
#define light_gate     12
#define light_lab2     8
#define light_lab1 7

void setup_lights() {
    pinMode(light_entrence, OUTPUT);
    pinMode(light_gate, OUTPUT);
    pinMode(light_lab2, OUTPUT);
    pinMode(light_lab1, OUTPUT);
}

void turn_on_light(String light){

  if (light.equals("CLL1_On")){
    digitalWrite( light_lab1, HIGH );
  }
  else if (light.equals("CLL2_On")){
    digitalWrite( light_lab2, HIGH );
  }
  else if (light.equals("CLEE_On")){
    digitalWrite(light_entrence , HIGH );
  }
  else if (light.equals("CLSC_On")){
    digitalWrite( light_gate, HIGH );
  }
  else if (light.equals("CLG_On") or light.equals("All") ) {
    digitalWrite( light_entrence, HIGH );
    digitalWrite( light_lab2, HIGH);
    digitalWrite( light_lab1, HIGH);
    digitalWrite( light_gate, HIGH);
  }

}

void turn_off_light(String light){
  if (light.equals("CLL1_Off")){
    digitalWrite( light_lab1, LOW );
  }
  else if (light.equals("CLL2_Off")){
    digitalWrite( light_lab2, LOW );
  }
  else if (light.equals("CLEE_Off")){
    digitalWrite(light_entrence , LOW );
  }
  else if (light.equals("CLSC_Off")){
    digitalWrite( light_gate, LOW );
  }
  else if (light.equals("CLG_Off") or light.equals("All") ) {
    digitalWrite( light_entrence, LOW );
    digitalWrite( light_lab2, LOW);
    digitalWrite( light_lab1, LOW);
    digitalWrite( light_gate, LOW);
  }
}
