/**
 * @file scoreBoard.h
 * @version 1.0
 * @date 19/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Funciones para mostrar el marcador durante el juego y al pausar.
 */


#ifndef _scoreBoard_h_
#define _scoreBoard_h_

/**
 * @brief setup_scoreBoard Se ejecuta para inicializar todas las variables y pines necesarios para mostrar el marcador.
 */
void setup_scoreBoard();

/**
 * @brief clean Apaga todos los leds en las dos matrices de led. 
 */
void clean();

/**
 * @brief getArray Obtiene la matriz correspondiente al marcador del jugador 1.
 * @param c Marcador del jugador 1.
 * @return La el vector correspondiente al marcador de 0 a 4.
 */
byte * getArray( char c);

/**
 * @brief getArray2 Obtiene la matriz correspondiente al marcador del jugador 2.
 * @param c Marcador del jugador 2.
 * @return La el vector correspondiente al marcador de 0 a 4.
 */
byte * getArray2( char c);

/**
 * @brief showScoreNumber Muestra el marcador en la matriz.
 * @param arr Vector del marcador del jugador 1.
 * @param arr2 Vector del marcador del jugador 2.
 */
void showScoreNumber(byte *arr, byte *arr2);

/**
 * @brief showScore Muestra el marcador en la matriz durante 3 segundos, luego de algún jugador anote un punto.
 * @param playerScore1 Marcador del jugador 1.
 * @param playerScore2 Marcador del jugador 2.
 */
void showScore( char playerScore1, char playerScore2 );


#endif
