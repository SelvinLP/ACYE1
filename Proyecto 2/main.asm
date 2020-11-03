;-- INCLUDE --
include mcontrol.asm
include marchivo.asm
include mlogin.asm
include mregis.asm
include mreport.asm
include mjuego.asm
;--CODIGO --
.model small 
.stack 100h 
.data 
encabezado db 0ah,0dh,'UNIVERSIDAD SAN CARLOS DE GUATEMALA', 0ah,0dh, 'FACULDAD DE INGENIERIA', 0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 ',
				0ah,0dh,'NOMBRE: SELVIN LISANDRO ARAGON PEREZ ',0ah,0dh,'CARNET: 201701133 ', 0ah,0dh,'SECCION: A ','$'
encabezadomenu db 0ah,0dh,' ' ,0ah,0dh,'1) Ingresar ',0ah,0dh,'2) Registrar',0ah,0dh,'3) Salir','$'
encabezadoadmin db 0ah,0dh,' ' ,0ah,0dh,'1) Top 10 puntos ',0ah,0dh,'2) Top 10 tiempos',0ah,0dh,'3) Salir','$'
ingreruta db 0ah,0dh,'Ingrese ruta: ','$'
gdusuario db 0ah,0dh,'Usuario Guardado Correctamente ','$'
ingreusu db 0ah,0dh,'Ingrese Usuario: ','$'
ingrepass db 0ah,0dh,'Ingrese Password: ','$'
ingrevel db 0ah,0dh,'Ingrese nivel de velocidad: ','$'
toppuntostitulo db 'Top 10 Puntos','$'
toptiempotitulo db 'Top 10 Tiempo','$'
generep db 0ah,0dh,'Generando Reporte','$'
generepfin db 0ah,'Reporte Generado','$'
usuadmin db 'adminBI','$'
passadmin db '4321','$'
ordBubbleSorttxt db 'Ord: BubbleSort ','$'
ordQuickSorttxt db 'Ord: QuickSort ','$'
ordShellSorttxt db 'Ord: ShellSort ','$'
bandcomp db '0'
ususypass db 300 dup('$')
usuytiempo db 300 dup('$')
usuypuntos db 300 dup('$')
pospuntosytiempo db '?'
tipoordenamiendo db 0ah,0dh,' ' ,0ah,0dh,'1) Ordenamiento BubbleSort ',0ah,0dh,'2) Ordenamiento QuickSort',0ah,0dh,'3) Ordenamiento ShellSort','$'
;Reporte
rutapuntos db 'Puntos.rep',00h
rutatiempo db 'Tiempo.rep',00h
arrayescritura db 5000 dup('$')
handleFichero dw ?  
handleFichero2 dw ?  
repenc db 0ah,'UNIVERSIDAD SAN CARLOS DE GUATEMALA', 0ah,'FACULDAD DE INGENIERIA', 0ah,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 ',
				0ah,'NOMBRE: SELVIN LISANDRO ARAGON PEREZ ',0ah,'CARNET: 201701133 ', 0ah,'SECCION: A '
replimea db 0ah,'-----------------------------------------------------------------------------------------'
reptoptime db 0ah,9h,9h,9h,9h,9h,9h,9h,9h,9h,'TOP 10 TIEMPOS'
reptoppunt db 0ah,9h,9h,9h,9h,9h,9h,9h,9h,9h,'TOP 10 PUNTOS'
repencb db 'No',9h,9h,'|',9h,9h,9h,'Usuario  ',9h,9h,'|',9h,9h,9h,'T ',9h,9h,'|',9h,9h,9h,'P'
reptab db 0ah,'|',9h,9h
reptabd db 9h,9h,'|',9h,9h,9h
repno db 2 dup('$')
;Juego
teclaguard db ?
pospelotax db ?
pospelotay db ?
dirperlotax db ?
dirperlotay db ?
posjugador1 db ?
posjugador2 db ?
puntos db ?
tiempo db ?
;Bloques
bloq1 db ?
bloq2 db ?
bloq3 db ?
bloq4 db ?
bloq5 db ?
bloq6 db ?
bloq7 db ?
bloq8 db ?
bloq9 db ?
bloq10 db ?
;Errores
errlimit db 0ah,0dh,'Limite de Caracteres superados','$'
errusu db 0ah,0dh,'El usuario ya existe','$'
;temporales
temvelocidad db 'Vel: 1'
arrtem db 20 dup('$')
temusuario db 9 dup('$')
temusuario2 db 9 dup('$')
temrepdata db 2 dup('$')
temprint db 2 dup('$')
tempass db 15 dup('$')
temnivel db 'N1','$'
tempuntos db 5 dup('$')
temtiempo db 5 dup('$')
bandera db ?
bandera2 db ?
quitarbloque db ?
cont dw ? ;contador de registros en el array
ordarray db 20 dup('$')
temcx db ?
auxcont dw ?
.code 

main proc
    mov pospuntosytiempo,0  ;contador 
	MenuPrincipal:
		imprimir encabezado 
		imprimir encabezadomenu
		obtenerchar
		cmp al,49
			je Ingresar
		cmp al,50
			je Registrar
		cmp al,51
			je Salir
		jmp MenuPrincipal
	Ingresar:
        Login
		jmp MenuPrincipal
	Registrar:
        registrousu
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
    mov [bx+25], ax
    mov al, cl
    call Conversion
    mov [bx+41], ax
    mov al, dh
    call Conversion
    mov [bx+58], ax
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