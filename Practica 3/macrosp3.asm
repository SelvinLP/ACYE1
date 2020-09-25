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

;-- OBTENER RUTA --
obtenerruta macro arr
LOCAL Inicio,Salir
	xor si,si
Inicio:
	obtenerchar
	cmp al,0dh
		je Salir
	mov arr[si],al
	inc si
	jmp Inicio
Salir:
	mov arr[si],00h
endm

;-- ARCHIVO --
Creararchivo macro ruta,handle
mov ah,3ch
mov cx,00h
lea dx,ruta
int 21h
mov handle,ax
endm

Abrirarchivo macro ruta,handle
mov ah,3dh
mov al,10b
lea dx,ruta
int 21h
mov handle,ax
endm

Escribirarchivo macro numbytes,arr,handle
	mov ah, 40h
	mov bx,handle
	mov cx,numbytes
	lea dx,arr
	int 21h
endm

Cerrararchivo macro handle
mov ah,3eh
mov handle,bx
int 21h
endm

Leerarchivo macro numbytes,arr,handle
mov ah,3fh
mov bx,handle
mov cx,numbytes
lea dx,arr
int 21h
endm