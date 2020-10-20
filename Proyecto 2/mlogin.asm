Login macro
push ax
Limpiararr temusuario
Limpiararr tempass
Inicio:
    imprimir ingreusu
    obtenertexto temusuario
	Comp_cad usuadmin, temusuario, bandcomp
	cmp bandcomp, 1
		je pedirpassadm
	;comprobacion de usuarios
	imprimir ingrepass
    obtenertexto tempass
	cmpusuariolg
	cmp bandcomp, 1
		je mostrarjuego
    jmp lgsalir 
pedirpassadm:
	imprimir ingrepass
    obtenertexto tempass
	Comp_cad passadmin, tempass, bandcomp
	cmp bandcomp, 1
		je lgadmin
	jmp lgsalir
lgadmin:
    imprimir encabezadoadmin
	obtenerchar
    cmp al,49
		je toppuntos
	cmp al,50
		je toptiempos
	cmp al,51
		je lgsalir
    jmp lgadmin
toppuntos:
	;reporte
	topuntos
    jmp lgadmin
toptiempos:
	;reporte
	toptime
    jmp lgadmin 
mostrarjuego:
	imprimir temjuego
	jmp lgsalir
lgsalir:
pop ax
endm

cmpusuariolg macro 
push ax
Limpiararr arrtem
xor cx,cx
xor dx,dx
xor si,si
mov bandcomp,0
lginicio:
    mov dh,ususypass[si]
    cmp dh, 58              ;validacion de :
        je lgvalidar
    cmp dh, 36              ;validacion de $
        je lgsalida
    push si
    mov si,cx
    inc cx
    mov arrtem[si],dh
    pop si
    inc si
    jmp lginicio
lgvalidar:
    push si
    push cx 
    Comp_cad temusuario, arrtem, bandcomp
    pop cx
    pop si
	cmp bandcomp, 1
		je lgverpass
    jmp lgbuscarotroid
lgbuscarotroid:
    inc si
    mov dh,ususypass[si]
    cmp dh, 59              ;validacion de ;
        je lgrepitebusqueda
    jmp lgbuscarotroid
lgrepitebusqueda:
	Limpiararr arrtem
    inc si
    jmp lginicio
lgverpass:
	mov bandcomp,0
	Limpiararr arrtem
    inc si
	jmp lgobtenerpass
lgobtenerpass:
	mov dh,ususypass[si]
    cmp dh, 59              ;validacion de ;
        je lgconfpass
	push si
    mov si,cx
    inc cx
    mov arrtem[si],dh
    pop si
	inc si
	jmp lgobtenerpass
lgconfpass:
	push si
    push cx 
    Comp_cad tempass, arrtem, bandcomp
    pop cx
    pop si
	jmp lgsalida
lgsalida:
pop ax
endm