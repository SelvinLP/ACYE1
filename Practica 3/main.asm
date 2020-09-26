;-- INCLUDE --
include macrosp3.asm
include matrizp3.asm
include matrzhtm.asm
;--CODIGO --
.model small 
.stack 100h 
.data 
encabezado db 0ah,0dh,'UNIVERSIDAD SAN CARLOS DE GUATEMALA', 0ah,0dh, 'FACULDAD DE INGENIERIA', 0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 ',
				0ah,0dh,'NOMBRE: SELVIN LISANDRO ARAGON PEREZ ',0ah,0dh,'CARNET: 201701133 ', 0ah,0dh,'SECCION: A ','$'
encabezadomenu db 0ah,0dh,' ' ,0ah,0dh,'1) Iniciar Juego ',0ah,0dh,'2) Cargar Juego',0ah,0dh,'3) Salir','$'
matrizb db 0ah,0dh,'Matriz Blancas','$'
matrizn db 0ah,0dh,'Matriz Negras','$'
;Matriz 001b blanca   011b negra
fl1 db 1, 0, 1, 0, 1, 0, 1, 0
fl2 db 0, 1, 0, 1, 0, 1, 0, 1
fl3 db 1, 0, 1, 0, 1, 0, 1, 0
fl4 db 0, 0, 0, 0, 0, 0, 0, 0
fl5 db 0, 0, 0, 0, 0, 0, 0, 0
fl6 db 0, 2, 0, 2, 0, 2, 0, 2
fl7 db 2, 0, 2, 0, 2, 0, 2, 0
fl8 db 0, 2, 0, 2, 0, 2, 0, 2
estadojugador db 0,1;0 es turno de blanco sino es turno de negro
coordenada db 6 dup('$'),'$'
rutaarchivo db 100 dup('$'),'$'
num8 db 0ah,0dh,' 8  |','$'
num7 db 0ah,0dh,' 7  |','$'
num6 db 0ah,0dh,' 6  |','$'
num5 db 0ah,0dh,' 5  |','$'
num4 db 0ah,0dh,' 4  |','$'
num3 db 0ah,0dh,' 3  |','$'
num2 db 0ah,0dh,' 2  |','$'
num1 db 0ah,0dh,' 1  |','$'
linea db 0ah,0dh,'   -------------------------','$'
letras db 0ah,0dh,'     A  B  C  D  E  F  G  H','$'
ficharb db 'RB|','$'
ficharn db 'RN|','$'
fichab db 'FB|','$'
fichan db 'FN|','$'
fichav db '  |','$'
ingreruta db 0ah,0dh,'Ingrese ruta: ','$'
turnob db 0ah,0dh,'Turno Blancas: ','$'
turnon db 0ah,0dh,'Turno Negras: ','$'
moverjug db 0ah,0dh,'1) Mover Pieza ','$'
guardarpart db 0ah,0dh,'2) Guardar ','$'
saliramenu db 0ah,0dh,'3) Menu Principal ','$'
arrayescritura db 64 dup('$')
handleFichero dw ?
;html
cadenahtml db '<!DOCTYPE html>',0ah,0dh,'<html lang=en>',0ah,0dh,'<head><meta charset=utf-8><title>201701133</title></head>',0ah,0dh
titulohtml db '<body><h1 style="text-align:center"> Fecha: 27/09/2020 - Hora: '
tiempo db '00:00:00'
cadtr db '<tr align="center">',0ah,0dh
ctitulohtml db '</h1>',0ah,0dh,'<table  align="center" border=0 cellspacing=2 cellpadding=2 bgcolor=#000000>',0ah,0dh
cadtd1 db '  <td width=50px; height=50px;>',0ah,0dh
cadtd2 db '  <td bgcolor=#ffffff width=50px; height=50px;>',0ah,0dh
ccadtd db '  </td>',0ah,0dh
ccadtr db '</tr>',0ah,0dh
ccadbody db '</table></body></html>'
fichablanca db '<img style="border-radius: 25px;" src=fichb.png width="35" height="35"/>',0ah,0dh
fichanegra db '<img style="border-radius: 25px;" src=fichn.png width="35" height="35"/>',0ah,0dh
.code 

main proc
	MenuPrincipal:
		imprimir encabezado 
		imprimir encabezadomenu
		obtenerchar
		cmp al,49
			je Jugador1
		cmp al,50
			je Importar
		cmp al,51
			je Salir
		jmp MenuPrincipal
	Jugador1:
		generarmatriz
		mov estadojugador[0],1
		imprimir turnob
		obtenertexto coordenada
		;Validaciones
		cmp coordenada[1],120 ;salir
			je MenuPrincipal
		cmp coordenada[1],97  ;save
			je Guardar
		cmp coordenada[1],104 ;show
			je GeneHTML
		juegomatriz
		generarmatriz
		jmp Jugador2
	Jugador2:
		mov estadojugador[0],2
		imprimir turnon
		obtenertexto coordenada
		;Validaciones
		cmp coordenada[1],120 ;salir
			je MenuPrincipal
		cmp coordenada[1],97  ;save
			je Guardar
		cmp coordenada[1],104 ;show
			je GeneHTML
		juegomatriz
		generarmatriz
		jmp Jugador1
	Importar:
		imprimir ingreruta
		obtenerruta rutaarchivo
		Abrirarchivo rutaArchivo,handleFichero
		Leerarchivo SIZEOF arrayescritura,arrayescritura,handleFichero
		Cerrararchivo handleFichero
		importando

		jmp MenuPrincipal
	Guardar:
		imprimir ingreruta
		obtenerruta rutaarchivo
		Creararchivo rutaArchivo,handleFichero
		Abrirarchivo rutaArchivo,handleFichero
		expotandod fl1,0
		expotandod fl2,8
		expotandod fl3,16
		expotandod fl4,24
		expotandod fl5,32
		expotandod fl6,40
		expotandod fl7,48
		expotandod fl8,56
		Escribirarchivo SIZEOF arrayescritura, arrayescritura,handleFichero
		Cerrararchivo handleFichero
		jmp MenuPrincipal

	GeneHTML:
		imprimir ingreruta
		obtenerruta rutaarchivo
		Creararchivo rutaArchivo,handleFichero
		Abrirarchivo rutaArchivo,handleFichero
		imprimirhtml
		Cerrararchivo handleFichero
		jmp MenuPrincipal
	Salir: 
		MOV ah,4ch 
		int 21h

main endp

obtenertiempo proc
    push ax
    push cx
    ObtenerHora
    mov al, ch
    call Conversion
    mov [bx], ax
    mov al, cl
    call Conversion
    mov [bx+3], ax
    mov al, dh
    call Conversion
    mov [bx+6], ax
    pop cx
    pop ax
    ret
obtenertiempo endp

Conversion proc
    push dx
    mov ah, 0
    mov dl, 10
    div dl
    or ax, 3030h
    pop dx
    ret
Conversion endp
end