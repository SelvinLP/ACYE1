#include "Arduino.h"
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
LiquidCrystal_I2C lcd(0x27, 16,2);

byte lock[] = { 0x0E, 0x11, 0x11, 0x1F, 0x1B, 0x1B, 0x1F, 0x1F };
byte unlock[] = { 0x0E, 0x01, 0x01, 0x1F, 0x1B, 0x1B, 0x1F, 0x1F };
byte check[] = {0x0, 0x1 ,0x3, 0x16, 0x1c, 0x8, 0x0 };
byte smile[8] = { 0b00000, 0b00000, 0b01010, 0b00000,0b00000, 0b10001, 0b01110, 0b00000 };
byte emoji_part1[] = { 0x07, 0x08, 0x14, 0x11, 0x14, 0x13, 0x08, 0x07 };
byte emoji_part2[] = { 0x1C, 0x02, 0x05, 0x11, 0x05, 0x19, 0x02, 0x1C };

void setup_lcd(){
  lcd.init();
  lcd.backlight();
  lcd.createChar(0, lock);
  lcd.createChar(1, unlock);
  lcd.createChar(2, check);
  lcd.createChar(3, smile);
  lcd.createChar(4, emoji_part1);
  lcd.createChar(5, emoji_part2);
  
}

void Bienvenido(){
  lcd.setCursor(1,0);
  lcd.write(0);
  lcd.setCursor(3,0);
  lcd.print("BIENVENIDO");
  lcd.setCursor(14,0);
  lcd.write(0);
  delay(5000);
  lcd.clear();
}

void print_text( String text, int lcd_y ){
  int size_text = text.length();
  int lcd_x;
  
  if (size_text < 16)
    lcd_x = (16 - size_text)/2;
  else 
    lcd_x = 0;

  lcd.setCursor(lcd_x, lcd_y);
  lcd.print( text );
}

void clear_screen(){
  lcd.clear();
}

void print_gate_close(){
  lcd.setCursor(0,0);
  lcd.write(2);
  lcd.setCursor(1,0);
  lcd.print("&ControlPorton&");

  lcd.setCursor(3,1);
  lcd.write(0);
  lcd.setCursor(4,1);
  lcd.write(3);
  lcd.setCursor(5,1);
  lcd.print("Cerrando");
  lcd.setCursor(13,1);
  lcd.write(3);
}

void print_gate_open(){
  lcd.setCursor(0,0);
  lcd.write(2);
  lcd.setCursor(1,0);
  lcd.print("&ControlPorton&");

  lcd.setCursor(1,1);
  lcd.write(1);
  lcd.setCursor(2,1);
  lcd.write(4);
  lcd.setCursor(3,1);
  lcd.write(5);
  lcd.setCursor(4,1);
  lcd.print("Abriendo");
  lcd.setCursor(12,1);
  lcd.write(4);
  lcd.setCursor(13,1);
  lcd.write(5);
}

//Login
void print_exceso_digitos(){
  
  clear_screen();
  print_text("Exceso de",0);
  print_text("Digitos",1);
  
//  lcd.setCursor(4,0);
//  lcd.print("Exceso de");
//  lcd.setCursor(5,1);
//  lcd.print("Digitos");
}

void print_pass_nocoinc(){
  
  clear_screen();
  print_text("Password",0);
  print_text("No Coincide",1);
  
//  lcd.setCursor(3,0);
//  lcd.print("Password");
//  lcd.setCursor(2,1);
//  lcd.print("No Coincide");
}

void print_creacionsus(){
  clear_screen();
//  lcd.setCursor(0,0);
//  lcd.print("Creacion Usuario");
  print_text("Creacion Usuario",0);
}

void print_passadm_nocoinc(){

  clear_screen();
  print_text("Password Adm",0);
  print_text("No Coincide",1);
  
  
//  lcd.setCursor(2,0);
//  lcd.print("Password Adm");
//  lcd.setCursor(2,1);
//  lcd.print("No Coincide");
}

void print_noident(String cadena){

  clear_screen();
  print_text("No Identidad",0);
  print_text(cadena,1);
  
  
//  lcd.setCursor(2,0);
//  lcd.print("No Identidad");
//  lcd.setCursor(7,1);
//  lcd.print(cadena);
}

void print_pass(String cadena){

  clear_screen();
  print_text("Ingrese Password",0);
  print_text(cadena,1);
  
  
//  lcd.setCursor(0,0);
//  lcd.print("Ingrese Password");
//  lcd.setCursor(4,1);
//  lcd.print(cadena);

}

void print_passadm(String cadena){

  clear_screen();
  print_text("Password Admin",0);
  print_text(cadena,1);
  
  
//  lcd.setCursor(1,0);
//  lcd.print("Password Admin");
//  lcd.setCursor(4,1);
//  lcd.print(cadena);
}

void print_idusu(String cadena){

  clear_screen();
  print_text("Ingrese Id",0);
  print_text(cadena,1);

  
//  lcd.setCursor(3,0);
//  lcd.print("Ingrese Id");
//  lcd.setCursor(4,1);
//  lcd.print(cadena);
}


void print_accpermitido(){

  clear_screen();
  print_text("Acceso",0);
  print_text("Permitido",1);
  
//  lcd.setCursor(5,0);
//  lcd.print("Acceso");
//  lcd.setCursor(4,1);
//  lcd.print("Permitido");
}
void print_bloqueado(){
  
  clear_screen();
  print_text("Sistema Bloqueado",0);
  print_text("Avise al Gerente",1);
  
//  lcd.setCursor(0,0);
//  lcd.print("Sistema Bloqueado");
//  lcd.setCursor(0,1);
//  lcd.print("Avise al Gerente");
}
