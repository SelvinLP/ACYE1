/**
 * @file turtle.h
 * @version 1.0
 * @date 29/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para el turtle. 
 */


#ifndef _turtle_h_
#define _turtle_h_


 /**
 * @brief setup_turtle Se ejecuta para inicializar todas las variables y pines necesarios para el uso del carro.
 */
void setup_turtle();

/**
 * @brief movimiento_turtle Realiza los movimientos necesarios para seguir la lineá negra. 
 */
void movimiento_turtle(); 


/**
 * @brief movimiento_pared Evada los obstaculos que se encuentran en la pista. 
 */
void movimiento_pared();


/**
 * @brief stop_turtle Detiene el carro, cuando se activa la barredora. 
 */
void stop_turtle();

#endif
