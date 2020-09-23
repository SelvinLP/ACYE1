/*LIBRARY AND HEADER */
#include "LedControl.h"     
#include "scoreBoard.h"
#include "game.h"

/*OBJETO DE LED CONTROL*/
LedControl  lc = LedControl(51,52,53,1); 

/*VARIABLES Y CONSTANTES*/

#define demora 70  
#define reset 47
#define startPin 19

const int ledPIN = 9;

//PARTE DE JUGADORES
//define variables input
const int P2U = 24;
const int P2D = 25;
const int P1U = 22;
const int P1D = 23;

//posicion inicial de los jugadores
byte player_1 = B00111000;
int player_2[]={0,0,1,1,1,0,0,0};

//POSICION DEL JUGADOR
int posjugador1=4;
 
//POSICION PELOTA
int pos_x=7;
int pos_y=4;
//DIRECCION PELOTA
int dir_x=1;
int dir_y=1;

//FLAG's / STATUS 
bool flagGame = false;
bool flagPause = false;


//PLAYER SCORES 
int playerScore1 = 0;
int playerScore2 = 0;

void pause();

void setup_game() {
  lc.shutdown(0,false);     // enciende la matriz
  lc.setIntensity(0,8);     // establece brillo
  lc.clearDisplay(0);     // blanquea matriz
  //----------------------------Prueba pin
  Serial.begin(9600);    //iniciar puerto serie
  pinMode(ledPIN , OUTPUT);  //definir pin como salida

  //se definen pines como entrada
  pinMode(P1U , INPUT);  
  pinMode(P1D , INPUT);
  pinMode(P2U , INPUT);
  pinMode(P2D , INPUT);
  
  //declaracion de pines
  for (byte i = 2; i <= 17; i++){
        pinMode(i, OUTPUT);
  }
  
  digitalWrite(reset, HIGH);
  pinMode(reset, OUTPUT); 

  /*PIN INTERRUPT FOR PAUSE AND CONTINUE BUTTON*/
  attachInterrupt( digitalPinToInterrupt(20), pause ,LOW );
  
  /*PIN INPUT FOR START BUTTON*/
  pinMode( startPin, INPUT);

}


//metodo para imprimir
void imprimir_tablero(int pos_x, int pos_y, byte player, byte player2){
  for (int i = 0; i < 16; i++){
    if(i>=8){digitalWrite(i-6,HIGH);}
    if(i==0){lc.setColumn(0,0,player);}//mostramos player 1
    
    for(int j = 0; j<8; j++){
      if(i<8){
        //CON DRIVER
        if(pos_y==j and pos_x==i){
          lc.setLed(0,j,i,HIGH);
          delay(demora);
        }else{
          if(i!=0){lc.setLed(0,j,i,LOW);}//evitamos eliminar lo mostrado del player 1
        }
      }else{
        if( i!=15){//el i!=15 es para evitar eliminar el player 2
          if(pos_y==j and pos_x==i){
            digitalWrite(j+10,LOW);
            delay(demora);
          }else{
            digitalWrite(j+10,HIGH);
          }
        }else{
          if(player_2[j]==1){digitalWrite(j+10,LOW); delay(1);}
          digitalWrite(j+10,HIGH);
        }
      }
    }//fin de recorrer y
 
    if(i>=8){digitalWrite(i-6,LOW);}
  }//fin de recorrer x
  
}


/*METODO PARA TERMINAR EL JUEGO*/
void gameOver() {
  playerScore1 = playerScore2 = 0;
  clean();
}


/* METODO PARA VALIDAD EL PUNTEO, SI CUALQUIER JUGADOR TIENE 4 PUNTOS SE TERMINA EL JUEGO*/
bool validateScore(){
  if (playerScore1 == 4 || playerScore2 == 4) {
    String str = ( playerScore1 == 4 )? "1" : "2";
    Serial.println("Winner >> Player " + str  );
    showScore( playerScore1+'0', playerScore2+ '0' );
    gameOver();
    return true;
  }
  return false;
}

/**/
void pause(){
  //showScoreNumber( playerScore1+'0', playerScore2+ '0' ); 
  if ( !flagPause && flagGame ){
    Serial.println("Pause..."); 
    flagPause = true;
  }
  else if ( flagPause && flagGame ) {
    Serial.println("Continue..."); 
    flagPause = false;
  }
}


void playGame(){

  if( !flagPause ){
    //MOVIMIENTOS JUGADORES
    //Jugador 1
    if (digitalRead(P1U) == LOW && player_1 != B11100000){
      //cadena de bits se corre un espacio a izquierda
      player_1 = player_1 << 1;
      posjugador1-=1;
    }
    //se se presiona el boton DOWN....
    else if (digitalRead(P1D) == LOW && player_1 != B00000111){
      //cadena de bits se corre un espacio a derecha
      player_1 = player_1 >> 1;
      posjugador1+=1;
    }
    //Player 2 
    if (digitalRead(P2U) == LOW && player_2[0] != 1 ){
      //cadena de bits se corre a derecha
      for(int pos=0;pos<7;pos++){
        if(player_2[pos]==1){
          player_2[pos-1]=1; player_2[pos+2]=0;
          break;
          }
      }
    }
    //si se presiona el boton DOWN....
    else if (digitalRead(P2D) == LOW && player_2[7] != 1){
      //cadena de bits se corre a izquierda
      for(int pos=0;pos<7;pos++){
        if(player_2[pos]==1){
          player_2[pos]=0; player_2[pos+3]=1;
          break;
          }
      }
    }

    //LIMITES DEL TABLERO
    if(pos_y==7){
      dir_y=-1;
    }
    if(pos_y==0){
      dir_y=1;
    }
    if(pos_x==15){
      //validaciones de anotacion
      int bandera=0;
      for(int pos=0;pos<7;pos++){
        if(player_2[pos]==1 and pos==pos_y){
          bandera=1;
          break;
          }
      }
      if(bandera==1){//rebota
        dir_x=-1;
      }else{ 
        //anotacion
        
        playerScore1++;
        showScore( playerScore1+'0', playerScore2+ '0' );
        
        if (validateScore())
          digitalWrite(reset, LOW);
                
        pos_x=random(7, 9);
        pos_y=random(0, 8);
        dir_x=random(-1, 2);
        if(dir_x==0){dir_x=1;}
      }
      
    }
    if(pos_x==0){
      //validaciones de anotacion
      if(pos_y==posjugador1+1 or pos_y==posjugador1-1){//rebota
        dir_x=1;
      }else{//anotacion
        
        playerScore2++;
        showScore( playerScore1+'0', playerScore2+ '0' );
        
        if (validateScore())
          digitalWrite(reset, LOW);
        
        pos_x=random(7, 9);
        pos_y=random(0, 8);
        dir_x=random(-1, 2);
        if(dir_x==0){dir_x=1;}
      }
    }
    
    //IMPRIMIR TABLERO
    pos_y+=dir_y;
    pos_x+=dir_x;
    imprimir_tablero(pos_x,pos_y,player_1,player_2);
  }
  else {
    showScoreNumber( getArray( playerScore1 + '0' ), getArray2( playerScore2 + '0' ) );
  }
}

void counterThreeSecond(){
  
  unsigned long initTime = millis();
  
    while ( digitalRead( startPin ) == LOW ){
      
      if ( millis() >= initTime + 3000  ){
        if (!flagGame){
          flagGame = true;
          Serial.println("Start Game ");  
        }
        else{
          flagGame = false;
          gameOver();
          Serial.println("Game Over!! Sayonara...");
        } 
        break;
      }
    }
}
