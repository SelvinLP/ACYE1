/**
 * @file Gate.h
 * @version 1.0
 * @date 14/09/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para el control del portón y salida de camiones. 
 */


#ifndef _gate_h_
#define _gate_h_

/**
* @brief setup_gate Se ejecuta para inicializar todas las variables y pines necesarios para el portón.
*/
void setup_gate();

/**
* @brief open_the_gate Método para parar abrir el portón, gira 2 veces hacia la derecha, al terminar de girar se encendar un led indicando que el portón esta abierto. 
*/
void open_the_gate();

/**
* @brief close_the_gate Método para parar cerrar el portón, gira hacia la izquierda, al terminar de girar se encendar un led indicando que el portón esta cerrado. 
*/
void close_the_gate();


#endif
