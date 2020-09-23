/**
 * @file ConveyorBar.h
 * @version 1.0
 * @date 14/09/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para el control de la barra transportadora. 
 */


#ifndef _Conveyor_bar_h_
#define _Conveyor_bar_h_


/**
* @brief setup_conveyor_bar Se ejecuta para inicializar todas las variables y pines necesarios para la barra transportadora.
*/
void setup_conveyor_bar();

/**
* @brief motor_to_right Método para hacer girar los motores stepper en el sentido de las agujas del relo (derecho).
*/
void motor_to_right();

/**
* @brief motor_to_left Método para hacer girar los motores stepper en el sentido contrario de las agujas del relo (izquierdo).
*/
void motor_to_left();

/**
* @brief stop_motor Método para detener ambos motores. 
*/
void stop_motor();


#endif
