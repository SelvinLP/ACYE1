/**
 * @file Temperature.h
 * @version 1.0
 * @date 14/09/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para usar el sensor de temperatura LM35.
 */


#ifndef _temperature_h_
#define _temperature_h_


/**
* @brief setup_teperature Se ejecuta para inicializar todas las variables y pines necesarios para usar el sensor LM35.
*/
void setup_teperature();

/**
* @brief measure_temperature Método para medir la temperatura y enviarla a la aplicación móbil. 
*/
void measure_temperature();


#endif
