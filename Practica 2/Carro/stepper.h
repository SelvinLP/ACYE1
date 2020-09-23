/**
 * @file stepper.h
 * @version 1.0
 * @date 29/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para los motores stepper. 
 */


#ifndef _stepper_h_
#define _stepper_h_

/**
 * @brief setup_stepper Se ejecuta para inicializar todas las variables y pines necesarios para el uso de los motores stepper.
 */
void setup_stepper();


/**
 * @brief movimiento_ruedaI Se encarga de mover el motor para la rueda izquierda.
 */
void movimiento_ruedaI(); 


/**
 * @brief movimiento_ruedaD Se encarga de mover el motor para la rueda derecha.
 */
void movimiento_ruedaD();


/**
 * @brief stop_stepper  Detiene los motores, cuando se activa la barredora. 
 */
void stop_stepper();

#endif
