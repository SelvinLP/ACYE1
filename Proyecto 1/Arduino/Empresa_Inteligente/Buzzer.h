/**
 * @file Buzzer.h
 * @version 1.0
 * @date 14/09/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para el control de la Alarma. 
 */


#ifndef _buzzer_h_
#define _buzzer_h_

/**
* @brief setup_Buzzer Se ejecuta para inicializar todas las variables y pines necesarios para el funicionamiento de la Alarma.
*/
void setup_Buzzer();

/**
* @brief Activate_Buzzer Método para activar la alarma. 
* @param x activa el sonido correspondiente a su valor númerico. 
*/
void Activate_Buzzer(int x);

#endif
