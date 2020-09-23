/**
 * @file LcdDisplay.h
 * @version 1.0
 * @date 14/09/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Métodos necesarios para usar y mostrar textos en LCD 16 x 2.
 */
 

#ifndef _lcd_display_h_
#define _lcd_display_h_


/**
* @brief setup_lcd Se ejecuta para inicializar todas las variables y pines necesarios para usar la LCD y mostar caraters y mensajes.
*/
void setup_lcd();

/**
* @brief clear_screen Método para mostrar un mensaje centrado en la LCD. 
* @param text  cadena o mensaje a mostrar, mejor si tiene una longitud menor de 16 para visualizarlo completo, debido a que la LCD es de 16 columnas. 
* @param lcd_y número de fila para mostrar el mensaje, puede ser 0 o 1 debido a que la LCD es de dos fila.
*/
void print_text( String text, int lcd_y );

/**
* @brief clear_screen Método para limpiar el contenido de la LCD.
*/
void clear_screen();

/**
* @brief clear_screen Método que muestra el mensaje mientras el portón se esta cerrando.
*/
void print_gate_close();

/**
* @brief clear_screen Método que muestra el mensaje mientras el portón se esta abriendo.
*/
void print_gate_open();

/**
* @brief print_exceso_digitos Método que muestra el mensaje de execeso de digitos cuando la contraseña sobrepasa de 8 digitos. 
*/
void print_exceso_digitos();

/**
* @brief print_pass_nocoinc Método que muestra el mensaje de error cuando la contraseña no es correcta.  
*/
void print_pass_nocoinc();

/**
* @brief print_creacionsus Método que muestra el mensaje para la creación de un usario nuevo.  
*/
void print_creacionsus();

/**
* @brief print_passadm_nocoinc Método que muestra el mensaje de error cuando la contraseña del Gerente Administrador no es correcta. 
*/
void print_passadm_nocoinc();

/**
* @brief print_noident Método que muestra la cadena  "No. Identidad" a la hora de iniciar sesión. 
* @param cadena identficación del usuario que es ingresado por el keypad.
*/
void print_noident(String cadena);

/**
* @brief print_pass Método que muestra la contraseña mientras se ingresa por medio del Keypad.
* @param cadena contraseña de registro ingresado por el keypad. 
*/
void print_pass(String cadena);

/**
* @brief print_passadm Método que muestra la contraseña del Gerente administratdor mientras se ingresa por medio del Keypad.
* @param cadena contraseña del gerente ingresado por el keypad. 
*/
void print_passadm(String cadena);

/**
* @brief print_idusu Método que muestra el la cadena "Id Usr." para que el usuario ingrese su identificación para iniciar sesión. 
* @param cadena idententificación del usario ingresado por el keypad. 
*/
void print_idusu(String cadena);

/**
* @brief Bienvenido Método que muestra el mensaje de Bienvenida. 
*/
void Bienvenido();

/**
* @brief print_accpermitido Método que muestra el la cadena "Accesos permintido" luego de iniciar correctamente con las credenciales. 
*/
void print_accpermitido();

/**
* @brief print_bloqueado Método que muestra el mensaje de error cuando el sistema es bloqueado. 
*/
void print_bloqueado();

#endif
