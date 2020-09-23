#include "LedControl.h"
#include "alphabet.h"
#include "scoreBoard.h"


LedControl ledControl = LedControl(51,52,53,1);

const int row[] = { 2,3,4,5,6,7,8,9 };
const int column[] = { 10,11,12,13,14,15,16,17 };

/*STUP FOR SOCORE BOARD*/
void setup_scoreBoard(){

  ledControl.shutdown(0,false);   
  ledControl.setIntensity(0,10);   
  ledControl.clearDisplay(0);  

   for( int i = 0; i < 8; i++ ){
    pinMode( row[i], OUTPUT ); 
    pinMode( column[i], OUTPUT );
  }
}

/*METHOD TO CLEAN BOARD*/
void clean(){
  for( int i = 0; i < 8; i++ ){
    digitalWrite( row[i], LOW ); 
    digitalWrite( column[i], LOW );
    for( int j = 0; j < 8; j++)
      ledControl.setLed(0, i, j, LOW);
  }
  
}


/*METHOD TO RETURN BYTE ARRAY OF A NUMBER FOR MATRIX WITH DRIVER*/
byte * getArray( char c){
  switch( c ){
    case '0': return zero0;
    case '1': return one1;
    case '2': return two2;
    case '3': return three3;
    case '4': return four4;
    default: return zero0;
  }
}


/*METHOD TO RETURN BYTE ARRAY OF A NUMBER FOR MATRIX WITHOUT DRIVER*/
byte * getArray2( char c){
  switch( c ){
    case '0': return zero;
    case '1': return one;
    case '2': return two;
    case '3': return three;
    case '4': return four;
    default: return zero;
  }
}

/*METHOD TO DISPLAY THE NUMBER FOR THE SCORE*/
void showScoreNumber(byte *arr, byte *arr2){
  for (int i = 0; i < 8; i++ )
    ledControl.setRow(0, i, arr[i] );
  
    for(int k = 0; k < 8; k++){
      for(int i = 0; i<8; i++)
      {
        digitalWrite( row[i], HIGH );
        for(int j = 0; j < 8; j++)
        {
          int x0 = bitRead( arr2[i], j ); // Usamos la función bitRead() para descomponer nuestros números hexadecimales
          digitalWrite( column[j], !x0 );        
        }
        delay(3); //Tiempo del barrido 
        digitalWrite(row[i],LOW);
        digitalWrite(column[i],LOW); 
      }
    }
}

/*METHOD TO DISPLAY THE SCORE IN THE BOARD FOR THREE SECONDS*/
void showScore( char playerScore1, char playerScore2 ){
  unsigned long initTime = millis();

  while(millis()< initTime + 3000)
    showScoreNumber( getArray( playerScore1 ), getArray2( playerScore2 ) );
  clean();
} 

 
