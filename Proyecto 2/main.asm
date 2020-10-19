;-- INCLUDE --
include mcontrol.asm
include marchivo.asm
include mlogin.asm
;--CODIGO --
.model small 
.stack 100h 
.data 
encabezado db 0ah,0dh,'UNIVERSIDAD SAN CARLOS DE GUATEMALA', 0ah,0dh, 'FACULDAD DE INGENIERIA', 0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 ',
				0ah,0dh,'NOMBRE: SELVIN LISANDRO ARAGON PEREZ ',0ah,0dh,'CARNET: 201701133 ', 0ah,0dh,'SECCION: A ','$'
encabezadomenu db 0ah,0dh,' ' ,0ah,0dh,'1) Ingresar ',0ah,0dh,'2) Registrar',0ah,0dh,'3) Salir','$'
encabezadoadmin db 0ah,0dh,' ' ,0ah,0dh,'1) Top 10 puntos ',0ah,0dh,'2) Top 10 tiempos',0ah,0dh,'3) Salir','$'
ingreruta db 0ah,0dh,'Ingrese ruta: ','$'
ingreusu db 0ah,0dh,'Ingrese Usuario: ','$'
ingrepass db 0ah,0dh,'Ingrese Contraseña: ','$'
usuadmin db 'adminBI','$'
passadmin db '4321','$'
temusuario db 15 dup('$')
tempass db 15 dup('$')
tiempo db '00:00:00'
bandcomp db 0
;Reporte
.code 

main proc
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