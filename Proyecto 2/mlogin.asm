Login macro
push ax
Limpiararr temusuario
Limpiararr tempass
Inicio:
    imprimir ingreusu
    obtenertexto temusuario
    imprimir ingrepass
    obtenertexto tempass
    Comp_cad 

    jmp lgsalir 
lgadmin:
    imprimir encabezadoadmin
    cmp al,49
		je toppuntos
	cmp al,50
		je toptiempos
	cmp al,51
		je lgsalir
    jmp lgadmin
toppuntos:
    jmp lgsalir
toptiempos:
    jmp lgsalir 
lgsalir:
pop ax
endm

Comp_cad macro cad1, cad2
local cmpinicio, cmpfalse, cmpfin
xor dx,dx
cmpinicio:
	mov cx, SIZEOF cad1 - 1
	mov ax,ds
	mov es,ax
	Lea si, cad1
	Lea di, cad2
	repe cmpsb
	jne cmpfalse
	mov dx, 0001h
	jmp cmpfin
cmpfalse:
	mov dx, 0000h
	jmp cmpfin 
cmpfin:		
endm