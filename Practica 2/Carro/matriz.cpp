#include "LedControl.h"     
#include "matriz.h"

LedControl  lc = LedControl(51,52,53,1); 

int dir = 2;
int fil = 7;
int col = 7;

void setup_matriz() {
//Despierta display
   lc.shutdown(0,false);
   //Pone brillo en medio
   lc.setIntensity(0,8);
   //Limpia display
   lc.clearDisplay(0);
}

void mueve (int fila,int columna){
  lc.setLed(0,fila,columna,true);     // enciende LED
  //delay(900);
}

void cambio(int x){
  Serial.print("x: ");
  Serial.print(x);
  Serial.println("");
  switch (x) {
  case 0:
    //recto
      if(dir==0){
        //derecha
        col++;
        mueve(fil,col); 
        }else if(dir==1){
          //abajo
          fil++;
          mueve(fil,col);
          }else if(dir==2){
            //izquierda
            col--;
            mueve(fil,col);
            }else if(dir==3){
              //arriba
              fil--;
              mueve(fil,col);
              }
    break;
  case 1:
    //izq
      if(dir==1){
        //derecha
        col++;
        mueve(fil,col);
        dir=0;  
        }else if(dir==2){
          //abajo
          fil++;
          mueve(fil,col);
          dir=1;
          }else if(dir==3){
            //izquierda
            col--;
            mueve(fil,col);
            dir=2;
            }else if(dir==0){
              //arriba
              fil--;
              mueve(fil,col);
              dir=3;
              }
    break;
  case 2:
    //der
      if(dir==3){
        //derecha
        col++;
        mueve(fil,col);
        dir=0;  
        }else if(dir==0){
          //abajo
          fil++;
          mueve(fil,col);
          dir=1;
          }else if(dir==1){
            //izquierda
            col--;
            mueve(fil,col);
            dir=2;
            }else if(dir==2){
              //arriba
              fil--;
              mueve(fil,col);
              dir=3;
              }
    break;
  }
  }

//metodo para imprimir
void imprimir_matriz(){
  //cambio 0 = recto
  //cambio 1 = izq
  //cambio 2 = der
  
  //cambio(0);
  //cambio(0);
  //cambio(2);

  
}
