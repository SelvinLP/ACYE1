/**
 * @file Entrada.h
 * @version 1.0
 * @date 14/09/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para el control de entrada de los usuarios. 
 */


#ifndef _entrada_h
#define _entrada_h

/**
* @brief setup_keypad Se ejecuta para inicializar todas las variables y pines necesarios para el ingreso del personal.
*/
void setup_keypad();

/**
* @brief Login Se ejecuta luego de la bienvenida y poder acceder a la empresa, iniciando sesión.
*/
void Login();

/**
* @brief acceso_permitido Permite el flujo correcto y la comunciación de cada área desde la aplicación móvil. 
*/
void acceso_permitido();

/**
* @brief acceso_bloqueado Se ejecuta cuadno el sistema se encuntra bloquedo. 
*/
void acceso_bloqueado();

/**
* @brief Ingresopass Se ejecuta cuando se esta ingresando la contraseña.
*/
void Ingresopass();

/**
* @brief Confirmacionpass Se ejecuta para confirmar la contraseña anteriormente ingresada. 
*/
void Confirmacionpass();

/**
* @brief Confirmacionadm Se ejecuta para confirmar la contraseña del gerente administrador. 
*/
void Confirmacionadm();

/**
* @brief Verificacionlog Se verfica el inico de sesión. 
*/
void Verificacionlog();

#endif
