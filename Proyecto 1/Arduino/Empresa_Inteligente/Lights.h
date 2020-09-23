/**
 * @file Lights.h
 * @version 1.0
 * @date 14/09/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para el control de luces de las diferentes areas. 
 */


#ifndef _lights_h_
#define _lights_h_


/**
* @brief setup_lights Se ejecuta para inicializar todas las variables y pines necesarios para el control de luces de las diferentes secciones.
*/
void setup_lights();

/**
* @brief turn_on_light Método para encender las luces de diferentes areas o secciones de la empresa. 
* @param light parametro que indca que luz debe de encenderse, o se encienden todas. 
*/
void turn_on_light(String light);

/**
* @brief turn_off_light Método para apagar las luces de diferentes areas o secciones de la empresa.
* @param light parametro que indca que luz debe de apagarse, o se apagan todas. 
*/
void turn_off_light(String light);


#endif
