#include "Arduino.h"

int PBuzzer=24;
long tiempo=5000;

////////////sonido de acceso//////////
int cuarto=100/4; //timepo de 1/4 de la nota
int octavo=100/8; //tiempo de 1/8 de nota
double pausa=1.30; //pausar 30% de lanota
int NOTA_C4 = 262; //frecuencia de 262Hz
int NOTA_A4=440; //frecuencia de 440Hz
int NOTA_E5=659; //frecuencia de 659Hz
///////////////////////////////////////////


////NOTAS CUANDO HAY ERROR AL ENTRAR Y SE CIERRA////
long DO=523.25;
long SI=987.77;

int i=0;
void setup_Buzzer() {
  pinMode(PBuzzer, OUTPUT);
}

void Activate_Buzzer(int x) {
int prueba=x;
if (prueba==1) { //SONIDO DE
    //SONIDO DE 5 SEGUNDOS CREEDENCIALES ERRONESA AL INGRESAR 4 VECES
    tone(PBuzzer, DO, tiempo);
    tone(PBuzzer, SI, tiempo);
    tone(PBuzzer, DO, tiempo);
    tone(PBuzzer, SI, tiempo);
    tone(PBuzzer, DO, tiempo);

}
else if (prueba==2) { ////banda transportadora, el buzzer debe generar un tono por 3 seg
     for (int i = 0; i <= 2; i++) {
    digitalWrite(PBuzzer,1);
    delay(500);
    digitalWrite(PBuzzer,0);
    delay(500);
  }
}
else if (prueba==3) { ////cada que un paquete llegue a un laboratorio se debe generar tambien un tono (distinto por laboratorio) de 1 seg.
   //nivel 1 de la planta
    digitalWrite(PBuzzer,1);
    delay(250);
    digitalWrite(PBuzzer,0);
    delay(250);
    digitalWrite(PBuzzer,1);
    delay(250);
    digitalWrite(PBuzzer,0);
    delay(250);
    digitalWrite(PBuzzer,0);
}
else if (prueba==4) { //Sonido de acceso permitido 2 segundos
    tiempo=tiempo/3;
    tone(PBuzzer, NOTA_C4, tiempo);
    delay(cuarto*pausa);
    tone(PBuzzer, NOTA_A4, tiempo);
    delay(octavo*pausa);
    tone(PBuzzer, NOTA_E5, tiempo);
    delay(cuarto*pausa);
    tiempo=5000;
}
else if (prueba==5) { ////Control de Porton un tono producido por el buzzer de 3 seg
    tiempo=tiempo*20;
    tone(PBuzzer,30,tiempo);
    tiempo=5000;
}

else if (prueba==6) { ////*nivel 2 de la planta*////
    tiempo=tiempo*7;
    tone(PBuzzer,30,tiempo);
    tiempo=5000;
    
  
}

}
