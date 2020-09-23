#include "Arduino.h"

const int lm35_pin = A1;  /* LM35 O/P pin */

void setup_teperature(){
//  pinMode(A0,INPUT);
  Serial.begin(9600);
}

void measure_temperature(){
  int temp_adc_val;
  float temp_val;
  temp_adc_val = analogRead(lm35_pin);  /* Read Temperature */
  temp_val = (temp_adc_val * 500)/1024;
  Serial.print(temp_val);
  Serial.println();
  delay(1000);
}
