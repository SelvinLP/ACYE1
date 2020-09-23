#include "Lights.h"
#include "Gate.h"
#include "LcdDisplay.h"
#include "ConveyorBar.h"
#include "Temperature.h"
#include "Entrada.h"
#include "Buzzer.h"

#define bocina 24

String option = "";
void setup() {
  Serial.begin(9600);
  setup_Buzzer();
  setup_lights();
  setup_gate();
  setup_lcd();
  setup_conveyor_bar();
  setup_teperature();
  setup_keypad();

  
}

void loop() {
  
Login();

}
