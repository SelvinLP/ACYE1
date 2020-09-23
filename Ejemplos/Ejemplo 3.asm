;===============SECCION DE MACROS ===========================
include mac4.asm

;================= DECLARACION TIPO DE EJECUTABLE ============
.model small 
.stack 100h 
.data 
;================ SECCION DE DATOS ========================
encab db 0ah,0dh, '1) Abrir archivo', 0ah,0dh,'2) Crear Archivo',0ah,0dh,'3) Escribir Archivo',0ah,0dh,'4) Salir',0ah,0dh,'$'
msm1 db 0ah,0dh,'FUNCION ABRIR',0ah,0dh,'$'
msm2 db 0ah,0dh,'FUNCION CREAR',0ah,0dh,'$'
msm3 db 0ah,0dh,'FUNCION ESCRIBIR',0ah,0dh,'$'
msmError1 db 0ah,0dh,'Error al abrir archivo','$'
msmError2 db 0ah,0dh,'Error al leer archivo','$'
msmError3 db 0ah,0dh,'Error al crear archivo','$'
msmError4 db 0ah,0dh,'Error al Escribir archivo','$'
texto db 0ah,0dh,'Arquitectura de computadores y ensambladores 1','$'
rutaArchivo db 100 dup('$')
bufferLectura db 100 dup('$')
bufferEscritura db 200 dup('$')
handleFichero dw ?
.code ;segmento de código
;================== SECCION DE CODIGO ===========================
	main proc 
		Menu:
			print encab
			getChar
			cmp al,49
			je ABRIR
			cmp al,50
			je CREAR
			cmp al,51
			je ESCRIBIR
			cmp al,52
			je SALIR
			jmp Menu
		ABRIR:
			print msm1
			getRuta rutaArchivo
			abrirF rutaArchivo,handleFichero
			leerF SIZEOF bufferLectura,bufferLectura,handleFichero
			cerrarF handleFichero
			print bufferLectura
			getChar
			jmp Menu
		CREAR:
			print msm2
			getRuta rutaArchivo
			crearF rutaArchivo,handleFichero
			;cerrarF handleFichero
			getChar
			jmp Menu
		ESCRIBIR:
			print msm3
			getRuta rutaArchivo
			abrirF rutaArchivo,handleFichero
			getTexto bufferEscritura
			escribirF  SIZEOF bufferEscritura, bufferEscritura,handleFichero
			cerrarF handleFichero
			getChar
			jmp Menu
	    ErrorAbrir:
	    	print msmError1
	    	getChar
	    	jmp Menu
	    ErrorLeer:
	    	print msmError2
	    	getChar
	    	jmp Menu
	    ErrorCrear:
	    	print msmError3
	    	getChar
	    	jmp Menu
		ErrorEscribir:
	    	print msmError4
	    	getChar
	    	jmp Menu

		SALIR: 
			MOV ah,4ch 
			int 21h
	main endp
;================ FIN DE SECCION DE CODIGO ========================
end