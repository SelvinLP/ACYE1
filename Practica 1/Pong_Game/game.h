/**
 * @file game.h
 * @version 1.0
 * @date 19/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Funciones para hacer mover a los jugadores y la pelota, pausar, reanudar y terminar el juego. 
 */


#ifndef _game_h_
#define _game_h_

extern bool flagGame;
extern bool flagPause;

/**
 * @brief setup_game Se ejecuta para inicializar todas las variables y pines necesarios el juego.
 */
void setup_game();

/**
 * @brief imprimir_tablero Imprime en la matriz correspondiente la posición del jugador 1 y jugador 2.
 * @param pos_x Posición en X.
 * @param pos_y Posición en Y.
 * @param player Posición del jugador 1.
 * @param player2 Posición del jugador 2.
 */
void imprimir_tablero(int pos_x, int pos_y, byte player, byte player2);

/**
 * @brief gameOver Finaliza el juego, reinicará los marcadores a 0 y apagara todas las leds de la matriz para que nuevamente se cargue el mensaje inicial. 
 */
void gameOver();

/**
 * @brief validateScore Verifica y valida si el jugador que anoto un punto aún no sea el ganador, cualquier jugador ganará al llegar a 4 putnos. 
 * @return Resultado de la verificación.
 */
bool validateScore();

/**
 * @brief pause Pausará o reanudará el juego.
 */
void pause();

/**
 * @brief playGame Iniciará el juego. 
 */
void playGame();

/**
 *  @brief counterThreeSecond Evento al pulsar el botón de start, que decidirá si el juego empieza o finaliza al mantener presionado por lo menos tres segundos. 
 */
void counterThreeSecond(); 

#endif
