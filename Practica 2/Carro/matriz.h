/**
 * @file matriz.h
 * @version 1.0
 * @date 29/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Matriz donde muestra el recorrido del carro. 
 */

#ifndef _matriz_h_
#define _matriz_h_


/**
 * @brief setup_matriz Se ejecuta para inicializar todas las variables y pines necesarios.
 */
void setup_matriz();

/**
 * @brief cambio Indica hacia que dirrección se movera. 
 * @param x puede tomar tres valores [0]: se movera recto [1]:se movera hacia la izquierda [2]: se movera hacia la derecha
 */
void cambio(int x);


/**
 * @brief mueve Agrega un nuevo punto a mostrar en la matriz. 
 * @param fila  número de fila.
 * @param columna número de columna.
 */
void mueve (int fila,int columna);

#endif
