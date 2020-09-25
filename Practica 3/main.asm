;-- INCLUDE --
include macrosp3.asm
include matrizp3.asm
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
	Iniciar:
		imprimir moverjug
		imprimir guardarpart
		imprimir saliramenu
		obtenerchar
		cmp al,49
			je Jugador1
		cmp al,50
			je Guardar
		cmp al,51
			je MenuPrincipal
		jmp Iniciar
	Jugador1:
		generarmatriz
		mov estadojugador[0],1
		imprimir turnob
		obtenertexto coordenada
		juegomatriz
		generarmatriz
		jmp Jugador2
	Jugador2:
		mov estadojugador[0],2
		imprimir turnon
		obtenertexto coordenada
		juegomatriz
		generarmatriz
		jmp Iniciar
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
	Salir: 
		MOV ah,4ch 
		int 21h

main endp

end