//libreria
#include "LedControl.h"
#include "alphabetBanner.h"
#include "banner.h"

#define ROW_1 2
#define ROW_2 3
#define ROW_3 4
#define ROW_4 5
#define ROW_5 6
#define ROW_6 7
#define ROW_7 8
#define ROW_8 9
#define COL_1 10
#define COL_2 11
#define COL_3 12
#define COL_4 13
#define COL_5 14
#define COL_6 15
#define COL_7 16
#define COL_8 17
#define lag 150

//objeto para driver
LedControl LC=LedControl(51,52,53,1); 

//contenedor de palabras
byte valores [110][8];
byte valores2 [110][8];

//delay
int del = 30;

//botones
int SIDE = 30;
int FAST = 31;
int SLOW = 33;

//variable de direccion
int var;

//bandera
volatile bool flag = true;

const byte rows[] = {
    ROW_1, ROW_2, ROW_3, ROW_4, ROW_5, ROW_6, ROW_7, ROW_8
};


void setup_banner() {
  for (int i = 0; i < 8; i++){
    valores [0][i]=S1[i];
    valores [1][i]=S2[i];
    valores [2][i]=S3[i];
    valores [3][i]=S4[i];
    valores [4][i]=S5[i];
    valores [5][i]=S6[i];
    valores [6][i]=S7[i];
    valores [7][i]=S8[i];
    valores [8][i]=S9[i];
    valores [9][i]=S10[i];
    valores [10][i]=S11[i];
    valores [11][i]=S12[i];
    valores [12][i]=S13[i];
    valores [13][i]=S14[i];
    valores [14][i]=S15[i];
    valores [15][i]=S16[i];
    valores [16][i]=S17[i];
    valores [17][i]=S18[i];
    valores [18][i]=S19[i];
    valores [19][i]=S20[i];
    valores [20][i]=S21[i];
    valores [21][i]=S22[i];
    valores [22][i]=S23[i];
    valores [23][i]=S24[i];
    valores [24][i]=S25[i];
    valores [25][i]=S26[i];
    valores [26][i]=S27[i];
    valores [27][i]=S28[i];
    valores [28][i]=S29[i];
    valores [29][i]=S30[i];
    valores [30][i]=S31[i];
    valores [31][i]=S32[i];
    valores [32][i]=S33[i];
    valores [33][i]=S34[i];
    valores [34][i]=S35[i];
    valores [35][i]=S36[i];
    valores [36][i]=S37[i];
    valores [37][i]=S38[i];
    valores [38][i]=S39[i];
    valores [39][i]=S40[i];
    valores [40][i]=S41[i];
    valores [41][i]=S42[i];
    valores [42][i]=S43[i];
    valores [43][i]=S44[i];
    valores [44][i]=S45[i];
    valores [45][i]=S46[i];
    valores [46][i]=S47[i];
    valores [47][i]=S48[i];
    valores [48][i]=S49[i];
    valores [49][i]=S50[i];
    valores [50][i]=S51[i];
    valores [51][i]=S52[i];
    valores [52][i]=S53[i];
    valores [53][i]=S54[i];
    valores [54][i]=S55[i];
    valores [55][i]=S56[i];
    valores [56][i]=S57[i];
    valores [57][i]=S58[i];
    valores [58][i]=S59[i];
    valores [59][i]=S60[i];
    valores [60][i]=S61[i];
    valores [61][i]=S62[i];
    valores [62][i]=S63[i];
    valores [63][i]=S64[i];
    valores [64][i]=S65[i];
    valores [65][i]=S66[i];
    valores [66][i]=S67[i];
    valores [67][i]=S68[i];
    valores [68][i]=S69[i];
    valores [69][i]=S70[i];
    valores [70][i]=S71[i];
    valores [71][i]=S72[i];
    valores [72][i]=S73[i];
    valores [73][i]=S74[i];
    valores [74][i]=S75[i];
    valores [75][i]=S76[i];
    valores [76][i]=S77[i];
    valores [77][i]=S78[i];
    valores [78][i]=S79[i];
    valores [79][i]=S80[i];
    valores [80][i]=S81[i];
    valores [81][i]=S82[i];
    valores [82][i]=S83[i];
    valores [83][i]=S84[i];
    valores [84][i]=S85[i];
    valores [85][i]=S86[i];
    valores [86][i]=S87[i];
    valores [87][i]=S88[i];
    valores [88][i]=S89[i];
    valores [89][i]=S90[i];
    valores [90][i]=S91[i];
    valores [91][i]=S92[i];
    valores [92][i]=S93[i];
    valores [93][i]=S94[i];
    valores [94][i]=S95[i];
    valores [95][i]=S96[i];
    valores [96][i]=S97[i];
    valores [97][i]=S98[i];
    valores [98][i]=S99[i];
    valores [99][i]=S100[i];
    valores [100][i]=S101[i];
    valores [101][i]=S102[i];
    valores [102][i]=S103[i];
    valores [103][i]=S104[i];
    valores [104][i]=S105[i];
    valores [105][i]=S106[i];
    valores [106][i]=S107[i];
    valores [107][i]=S108[i];
    valores [108][i]=S109[i];

    valores2 [0][i]=T1[i];
    valores2 [1][i]=T2[i];
    valores2 [2][i]=T3[i];
    valores2 [3][i]=T4[i];
    valores2 [4][i]=T5[i];
    valores2 [5][i]=T6[i];
    valores2 [6][i]=T7[i];
    valores2 [7][i]=T8[i];
    valores2 [8][i]=T9[i];
    valores2 [9][i]=T10[i];
    valores2 [10][i]=T11[i];
    valores2 [11][i]=T12[i];
    valores2 [12][i]=T13[i];
    valores2 [13][i]=T14[i];
    valores2 [14][i]=T15[i];
    valores2 [15][i]=T16[i];
    valores2 [16][i]=T17[i];
    valores2 [17][i]=T18[i];
    valores2 [18][i]=T19[i];
    valores2 [19][i]=T20[i];
    valores2 [20][i]=T21[i];
    valores2 [21][i]=T22[i];
    valores2 [22][i]=T23[i];
    valores2 [23][i]=T24[i];
    valores2 [24][i]=T25[i];
    valores2 [25][i]=T26[i];
    valores2 [26][i]=T27[i];
    valores2 [27][i]=T28[i];
    valores2 [28][i]=T29[i];
    valores2 [29][i]=T30[i];
    valores2 [30][i]=T31[i];
    valores2 [31][i]=T32[i];
    valores2 [32][i]=T33[i];
    valores2 [33][i]=T34[i];
    valores2 [34][i]=T35[i];
    valores2 [35][i]=T36[i];
    valores2 [36][i]=T37[i];
    valores2 [37][i]=T38[i];
    valores2 [38][i]=T39[i];
    valores2 [39][i]=T40[i];
    valores2 [40][i]=T41[i];
    valores2 [41][i]=T42[i];
    valores2 [42][i]=T43[i];
    valores2 [43][i]=T44[i];
    valores2 [44][i]=T45[i];
    valores2 [45][i]=T46[i];
    valores2 [46][i]=T47[i];
    valores2 [47][i]=T48[i];
    valores2 [48][i]=T49[i];
    valores2 [49][i]=T50[i];
    valores2 [50][i]=T51[i];
    valores2 [51][i]=T52[i];
    valores2 [52][i]=T53[i];
    valores2 [53][i]=T54[i];
    valores2 [54][i]=T55[i];
    valores2 [55][i]=T56[i];
    valores2 [56][i]=T57[i];
    valores2 [57][i]=T58[i];
    valores2 [58][i]=T59[i];
    valores2 [59][i]=T60[i];
    valores2 [60][i]=T61[i];
    valores2 [61][i]=T62[i];
    valores2 [62][i]=T63[i];
    valores2 [63][i]=T64[i];
    valores2 [64][i]=T65[i];
    valores2 [65][i]=T66[i];
    valores2 [66][i]=T67[i];
    valores2 [67][i]=T68[i];
    valores2 [68][i]=T69[i];
    valores2 [69][i]=T70[i];
    valores2 [70][i]=T71[i];
    valores2 [71][i]=T72[i];
    valores2 [72][i]=T73[i];
    valores2 [73][i]=T74[i];
    valores2 [74][i]=T75[i];
    valores2 [75][i]=T76[i];
    valores2 [76][i]=T77[i];
    valores2 [77][i]=T78[i];
    valores2 [78][i]=T79[i];
    valores2 [79][i]=T80[i];
    valores2 [80][i]=T81[i];
    valores2 [81][i]=T82[i];
    valores2 [82][i]=T83[i];
    valores2 [83][i]=T84[i];
    valores2 [84][i]=T85[i];
    valores2 [85][i]=T86[i];
    valores2 [86][i]=T87[i];
    valores2 [87][i]=T88[i];
    valores2 [88][i]=T89[i];
    valores2 [89][i]=T90[i];
    valores2 [90][i]=T91[i];
    valores2 [91][i]=T92[i];
    valores2 [92][i]=T93[i];
    valores2 [93][i]=T94[i];
    valores2 [94][i]=T95[i];
    valores2 [95][i]=T96[i];
    valores2 [96][i]=T97[i];
    valores2 [97][i]=T98[i];
    valores2 [98][i]=T99[i];
    valores2 [99][i]=T100[i];
    valores2 [100][i]=T101[i];
    valores2 [101][i]=T102[i];
    valores2 [102][i]=T103[i];
    valores2 [103][i]=T104[i];
    valores2 [104][i]=T105[i];
    valores2 [105][i]=T106[i];
    valores2 [106][i]=T107[i];
    valores2 [107][i]=T108[i];
    valores2 [108][i]=T109[i];
    
  }
  for (byte i = 2; i <= 17; i++)
      pinMode(i, OUTPUT);
  
  //se definen los pines como entradas
  pinMode(SIDE, INPUT);
  pinMode(FAST, INPUT);
  pinMode(SLOW, INPUT);
  
  LC.shutdown(0,false);    
  LC.setIntensity(0,4);     
  LC.clearDisplay(0);
  attachInterrupt(digitalPinToInterrupt(21),dir, FALLING);

}

//boton de control de direccion
void dir(){
  
      if (flag == true){
        flag = false;
      }else{
        flag = true;
      }
     
}

void setColumns(byte b) {
    digitalWrite(COL_1, (~b >> 0) & 0x01); 
    digitalWrite(COL_2, (~b >> 1) & 0x01);
    digitalWrite(COL_3, (~b >> 2) & 0x01);
    digitalWrite(COL_4, (~b >> 3) & 0x01);
    digitalWrite(COL_5, (~b >> 4) & 0x01);
    digitalWrite(COL_6, (~b >> 5) & 0x01);
    digitalWrite(COL_7, (~b >> 6) & 0x01);
    digitalWrite(COL_8, (~b >> 7) & 0x01);
}


void  drawScreen(byte buffer2[]){  
    for (byte i = 0; i < 8; i++) {
        setColumns(buffer2[i]);
          
        digitalWrite(rows[i], HIGH);
        delay(4);
        digitalWrite(rows[i], LOW);   

           
        //botones de control de velocidad, se cambia el valor del delay
        if (digitalRead(SLOW) == LOW){
          del = 35;
        }
        if (digitalRead(FAST) == LOW){
          del = 0;
        }

             
    }
}


//aqui se manda a imprimir las letras en las leds
//la direccion depende de la variable que se le mande
void DefinirDireccion(int var){
  //se muestra en la matriz sin driver
    drawScreen(valores[var]);

    //se muestra la matriz con driver
    for (int i = 0; i < 8; i++){     
      LC.setRow(0,i,valores2[var][i]);
    }
    delay(del);
}


void showBanner() {

  //se define la direccion inicial del banner
  if (flag == true){
    var = 1;  
  }else{
    var = 108;
  }
  
  //ciclo que repite la proyeccion de las luces...
  //si el contador (var) va incrementando el banner se despliega a la derecha, si disminuye se despliega a la izquierda 
  while (var > 0 && var < 109 ) {
    //se mueve de derecha a izquierda...
    if (flag == true){
      var++;
    }
    //se mueve de izquierda a derecha...
    else{
      var--;
    }
    //se llama a la funcion para imprimir matriz y se le envia el parametro de direccion
    DefinirDireccion(var); 
  }
  
}
