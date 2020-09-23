/**
 * @file sweeper.h
 * @version 1.0
 * @date 29/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para la barredora. 
 */


#ifndef _sweeper_h_
#define _sweeper_h_


/**
 * @brief setup_sweeper Se ejecuta para inicializar todas las variables y pines necesarios para el uso del servo.
 */
void setup_sweeper();


/**
 * @brief sweep Activa la barredora haciendo que gira 3 vueltas y media el servomotor. 
 */
void sweep();


/**
 * @brief stop_sweep Detiene el servomotor cuando termina de barrer.
 */
void stop_sweep();

#endif
