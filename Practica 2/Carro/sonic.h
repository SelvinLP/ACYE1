/**
 * @file sonic.h
 * @version 1.0
 * @date 29/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para el ultrasónico. 
 */
 

#ifndef _sonic_h_
#define _sonic_h_


/**
 * @brief setup_sonic Se ejecuta para inicializar todas las variables y pines necesarios para el uso del ultrasonico.
 */
void setup_sonic();


/**
 * @brief sensor_sonic Se encarga de medir la distancia del carro y un obstáculo,posteriormente decidirá si sigue o lo rodea. 
 */
void sensor_sonic(); 

#endif
