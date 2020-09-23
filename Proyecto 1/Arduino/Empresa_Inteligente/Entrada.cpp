
#include "Arduino.h"
#include "LcdDisplay.h"
#include <Keypad.h>
#include <EEPROM.h>
#include "Entrada.h"

#include "Lights.h"
#include "Gate.h"
#include "LcdDisplay.h"
#include "ConveyorBar.h"
#include "Temperature.h"
#include "Buzzer.h"

String op = "";

const byte fila = 4; 
const byte columna = 3;
byte Pinesfila[fila] = {51,49,47,45};
byte Pinescolum[columna] = {43,40,37};
int No_Ident =1;

char keys[fila][columna] = {
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
  {'*','0','#'}
};

int Estado=0;
int Intentos=0;
//Usuario
String Usuid = "";
String Usupass = "";
String Usupasstem = "";
char validacionusu[8];
//Contadores
int cantdigitos=0;
//Admin
String userAdmin = "0001";
String passAdmin = "0106";
String admpasstem = "";
Keypad keypad =Keypad(makeKeymap(keys), Pinesfila, Pinescolum, fila, columna);

bool flag_temperature=false;
void setup_keypad(){

  //Pines
  pinMode(34,OUTPUT);
  pinMode(36,OUTPUT);

  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);
  pinMode(8,OUTPUT);
  pinMode(7,OUTPUT);
  
  pinMode(51,INPUT);
  pinMode(49,INPUT);
  pinMode(47,INPUT);
  pinMode(45,INPUT);
  pinMode(43,INPUT);
  pinMode(40,INPUT);
  pinMode(37,INPUT);

  //Primeras Impresiones
  Bienvenido();
  print_idusu(Usuid);
}


void Login(){
  char key = keypad.getKey();
  //0 Login
  //1 Creacion de Usuario ingreso de pass
  //2 Ingreso de nuevo de pass y verificacion
  //3 Confirmacion de admin
  //4 Verificacion de password pero de login
  //5 Logueado correctamente
  //6 Acceso Bloqueado
  switch (Estado) {
  case 0:
    if(key){
      //para limpiar
      if(key == '#'){
        Estado=4;
        print_pass(Usupass);
      }else{
        Usuid += key;
        cantdigitos=0;
        if(Usuid == "0000"){
          print_creacionsus();
          delay(1000);
          print_pass(Usupass);
          cantdigitos=0;
          Usuid = "";
          Estado=1;
        }else{
          print_idusu(Usuid);
        }
        if(key == '*'){
          //limpiar eeprom
         for (int i = 0 ; i < EEPROM.length() ; i++) {
            EEPROM.write(i, 0);
          }
          Usuid="";
          print_idusu(Usuid);
        }
      }
    }
    if(cantdigitos > 8){
      print_exceso_digitos();
      delay(1000);
      cantdigitos=0;
      Usuid="";
      print_idusu(Usuid);
    }
    
    break;
  case 1:
    if(key){
      if(key == '#'){
        //Verificacion
        print_pass(Usupasstem);
        Estado=2;
        cantdigitos=0;
      }else{
        Usupass += key;
        cantdigitos++;
        print_pass(Usupass);
      } 
    }
    //Validacion de error
    if(cantdigitos > 8){
      print_exceso_digitos();
      delay(1000);
      cantdigitos=0;
      Usupass="";
      print_pass(Usupass);
    }
    break;
  case 2:
      if(key){
      if(key == '#'){
        //Verificacio
        if(Usupass == Usupasstem){
          print_passadm(admpasstem);
          Estado=3;
          cantdigitos=0;
          Usupasstem="";
        }else{
          //Error al repetir la contraseña
          print_pass_nocoinc();
          delay(1000);
          cantdigitos=0;
          Usupasstem="";
          print_pass(Usupasstem);
        }
      }else{
        Usupasstem += key;
        cantdigitos++;
        print_pass(Usupasstem);
      } 
    }
    //Validacion de error
    if(cantdigitos > 8){
      print_exceso_digitos();
      delay(1000);
      cantdigitos=0;
      Usupasstem="";
      print_pass(Usupasstem);
    }
    break;
  case 3:
      if(key){
      if(key == '#'){
        //Verificacion
        if(passAdmin == admpasstem){
          //Insertamos 
          int n = Usupass.length(); 
          char char_array[n+1]; 
          strcpy(char_array, Usupass.c_str()); 
          for (int i = 0; i < n; i++){
            EEPROM.write(No_Ident,char_array[i]);
            No_Ident++;
          }
          print_noident(String(No_Ident-n));
          delay(1000);
          print_idusu(Usuid); 
          
          Estado=0;
          cantdigitos=0;
          Usupass = "";
          admpasstem="";
        }else{
          //Error al repetir la contraseña
          print_passadm_nocoinc();
          delay(1000);
          cantdigitos=0;
          admpasstem="";
          print_passadm(admpasstem);
        }
      }else{
        admpasstem += key;
        cantdigitos++;
        print_passadm(admpasstem);
      } 
    }
    if(cantdigitos > 8){
      print_exceso_digitos();
      delay(1000);
      cantdigitos=0;
      admpasstem="";
      print_passadm(admpasstem);
    }
    break;
  case 4:
  
    if(key){
      if(key == '#'){
        //Verificacion
        String temcadena="";
        int tamanio=Usupass.length();
        int direccion =Usuid.toInt();
        for (int i = direccion; i < direccion+tamanio; i++){
          temcadena += (char)EEPROM.read(i);
        }
        if(temcadena == Usupass){
          Usuid="";
          Usupass="";
          print_accpermitido();
          digitalWrite(36,HIGH);
          //encendido de todas las luces
          digitalWrite(12,HIGH);
          digitalWrite(13,HIGH);
          digitalWrite(8,HIGH);
          digitalWrite(7,HIGH);
          delay(1000);
          digitalWrite(12,LOW);
          digitalWrite(13,LOW);
          digitalWrite(8,LOW);
          digitalWrite(7,LOW);
          Activate_Buzzer(4);
          clear_screen();
          
          Estado=5;
        }else{
          Intentos++;
          if(Intentos == 4){//Se Bloquea Usuario
            acceso_bloqueado();
          }else{
            Estado=0;
            Usupass="";
            Usuid="";
            print_idusu(Usuid);
          }
        }
        
      }else{
        Usupass += key;
        cantdigitos++;
        print_pass(Usupass);
      } 
    }
    //Validacion de error
    if(cantdigitos > 8){
      print_exceso_digitos();
      delay(1000);
      cantdigitos=0;
      Usupass="";
      print_pass(Usupass);
    }
    break;
  case 5:
  acceso_permitido();
    break;
  case 6:
    if(key){
      if(key == '#'){
        //Verificacion
        if(passAdmin == admpasstem){
          //Insertamos 
          Usuid="";
          print_idusu(Usuid); 
          Estado=0;
          cantdigitos=0;
          Usupass = "";
          Usupasstem ="";
          admpasstem="";
          digitalWrite(34,LOW);
        }else{
          //Error al repetir la contraseña
          print_passadm_nocoinc();
          delay(1000);
          cantdigitos=0;
          admpasstem="";
          print_passadm(admpasstem);
        }
      }else{
        admpasstem += key;
        cantdigitos++;
        print_passadm(admpasstem);
      } 
    }
    if(cantdigitos > 8){
      print_exceso_digitos();
      delay(1000);
      cantdigitos=0;
      admpasstem="";
      print_passadm(admpasstem);
    }
    break;
  }
}

void acceso_permitido(){

  //poner lo demas de leds y buzzer
  while ( Serial.available() ) {
    delay( 10 );
    char ch = Serial.read();
    op += ch;
  }
  if ( op.length() > 0 ) {
    turn_on_light(op);
    turn_off_light(op);
    flag_temperature = false;
    
    if ( op.equals("P_Open") )
      open_the_gate();
    else if (( op.equals("CB_L1") ))
      motor_to_right();
    else if (( op.equals("CB_L2") ))
      motor_to_left();
    else if (( op.equals("Temp") )){
      measure_temperature();
      flag_temperature = true;
    }
      
      
    op = "";
  }
  if (flag_temperature){
    measure_temperature();
  }


 
}

void acceso_bloqueado(){
  print_bloqueado();
  digitalWrite(34,HIGH);
  //Poner buzzer ya puse el delay
   Activate_Buzzer(1);
  /*****************************************************************/
  //delay(5000);
  //Ingreso de clave del gerente
  Estado = 6;
  print_passadm(admpasstem);
}
