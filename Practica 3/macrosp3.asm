;-- MACRO IMPRIMIR --
imprimir macro cad
LOCAL Cuerpo
PUSH ax 
Cuerpo: 
	mov ah,09h 
	mov dx,@data 
	mov ds,dx 
	mov dx, offset cad 
	int 21h 
POP ax 
endm

imprimirchar macro char
PUSH ax 
mov ah,02h
mov dl,char
int 21h
POP ax 
endm


;-- MACRO OBTENER CHAR --
obtenerchar macro
mov ah,01h
int 21h
endm

;-- OBTENER TEXTO --
obtenertexto macro arraytem
LOCAL Valor,Salida
PUSH SI
PUSH AX

xor si,si
Valor:
obtenerchar
cmp al,0dh
je Salida
mov arraytem[si],al
inc si
jmp Valor

Salida:

POP AX
POP SI
endm
