;-- INCLUDE --
include mcontrol.asm
include marchivo.asm
include mjson.asm
;--CODIGO --
.model small 
.stack 100h 
.data 
encabezado db 0ah,0dh,'UNIVERSIDAD SAN CARLOS DE GUATEMALA', 0ah,0dh, 'FACULDAD DE INGENIERIA', 0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 ',
				0ah,0dh,'NOMBRE: SELVIN LISANDRO ARAGON PEREZ ',0ah,0dh,'CARNET: 201701133 ', 0ah,0dh,'SECCION: A ','$'
encabezadomenu db 0ah,0dh,' ' ,0ah,0dh,'1) Cargar ',0ah,0dh,'2) Consola',0ah,0dh,'3) Salir','$'
ingreruta db 0ah,0dh,'Ingrese ruta: ','$'
rutaarchivo db 100 dup('$'),'$'
arrayescritura db 10000 dup('$')
handleFichero dw ?  
Objpadre db 100 dup('$')
Operadores db 100 dup('$')
ids db 100 dup ('$')
Opera1 db 10 dup('$')
Opera2 db 10 dup('$')
Contope db 2 dup(0)
Estadope db 2 dup(0)
.code 

main proc
	MenuPrincipal:
		imprimir encabezado 
		imprimir encabezadomenu
		obtenerchar
		cmp al,49
			je Cargar
		cmp al,50
			je Consola
		cmp al,51
			je Salir
		jmp MenuPrincipal
	Cargar:
		imprimir ingreruta
		obtenerruta rutaarchivo
		Abrirarchivo rutaArchivo,handleFichero
		Leerarchivo SIZEOF arrayescritura,arrayescritura,handleFichero
		Cerrararchivo handleFichero
		Leerjson
		jmp MenuPrincipal
	Consola:
		jmp MenuPrincipal
	Salir: 
		MOV ah,4ch 
		int 21h

main endp
end