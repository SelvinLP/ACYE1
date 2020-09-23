/**
 * @file alphabet.h
 * @version 1.0
 * @date 19/08/2020
 * @author ARQUI 1, GRUPO 8
 * @brief Arrays de bytes de los numeros (0,1,2,3,4) a mostrar en la matriz de led's.
 */

//Socore whith driver
byte zero0 [] = { 0x7c, 0xc6, 0xce, 0xde, 0xf6, 0xc6, 0x7c, 0x00 }; 
byte one1[] = { 0x38, 0x78, 0x18, 0x18, 0x18, 0x18, 0x7e, 0x00 };
byte two2 [] = { 0x3c, 0x66, 0x06, 0x1c, 0x30, 0x66, 0x7e, 0x00 }; 
byte three3 [] = { 0x3c, 0x66, 0x06, 0x1c, 0x06, 0x66, 0x3c, 0x00 };
byte four4 [] = { 0x1c, 0x3c, 0x6c, 0xcc, 0xfe, 0x0c, 0x1e, 0x00 }; 

//Score without driver.
byte zero[] = { 0x00, 0x3E, 0x7F, 0x59, 0x4D, 0x7F, 0x3E, 0x00 }; 
byte one[] = { 0x00, 0x42, 0x43, 0x7F, 0x7F, 0x40, 0x40, 0x00 };  
byte two[] = { 0x00, 0x62, 0x73, 0x59, 0x49, 0x6F, 0x66, 0x00 };  
byte three[] = { 0x00, 0x22, 0x63, 0x49, 0x49, 0x7F, 0x36, 0x00 };
byte four[] = { 0x18, 0x1C, 0x16, 0x53, 0x7F, 0x7F, 0x50, 0x00 };
