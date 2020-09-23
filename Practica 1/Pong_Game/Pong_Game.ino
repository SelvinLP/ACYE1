#include "scoreBoard.h"
#include "game.h"
#include "banner.h"

#define startPin 19

void setup() {
  
  /* INITIALIZING THE BOARD PINS*/
  setup_game(); 

  /*INITIALIZING THE SCORE_BOARD PINS*/
  setup_scoreBoard();
       
  /*INITIALIZING THE BANNER PINS*/
  setup_banner();

  Serial.begin(9600);
  Serial.println("Hellow Arduino Mega");
}

void loop() {

  if ( digitalRead( ( startPin ) ) != LOW && !flagGame ){
    Serial.println("Message");
    showBanner();
  }
  else if ( digitalRead( ( startPin ) ) == LOW )
      counterThreeSecond(); 
  if( flagGame)
      playGame();

}
