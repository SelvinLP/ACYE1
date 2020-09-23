/**
 * @file banner.h
 * @version 1.0
 * @date 19/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Funciones para mostrar el mensaje inicial solicitado. 
 */

#ifndef _banner_h_
#define _banner_h_

/**
 * @brief setup_banner Se ejecuta para inicializar todas las variables y pines necesarios para mostrar el mensaje.
 */
void setup_banner();

/**
 * @brief showBanner Mostrara el mensaje en en la matriz de led´s. 
 */
void showBanner();

/**
 * @brief dir Controla la dirrección(iquierda o derecha) en la que se movera el mensaje.
 */
void dir();

/**
 * @brief Se manda a imprimir las letras en la matriz de led's.
 * @param var Dirección en la que se movera el mensaje. 
 */
void DefinirDireccion(int var);

/**
 * @brief drawScreen Se manda a imprimir las letras en la matriz de led's sin driver.
 * @param buffer2[] Vector a imprimir. 
 */
void  drawScreen(byte buffer2[]);

/**
 * @brief setColumns Se selección la columna que encendera. 
 * @param b Columna donde se desplazara 
 */
void setColumns(byte b);


#endif
