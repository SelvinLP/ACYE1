print macro cadena 
LOCAL ETIQUETA 
ETIQUETA: 
	MOV ah,09h 
	MOV dx,@data 
	MOV ds,dx 
	MOV dx, offset cadena 
	int 21h
endm

getRuta macro buffer
LOCAL INICIO,FIN
	xor si,si
INICIO:
	getChar
	cmp al,0dh
	je FIN
	mov buffer[si],al
	inc si
	jmp INICIO
FIN:
	mov buffer[si],00h
endm

getChar macro
mov ah,01h
int 21h
endm

getTexto macro buffer
PUSH SI
PUSH AX

xor si,si
CONTINUE:
getChar
cmp al,0dh
je FIN
mov buffer[si],al
inc si
jmp CONTINUE

FIN:
mov al,'$'
mov buffer[si],al

POP AX
POP SI
endm

abrirF macro ruta,handle
mov ah,3dh
mov al,10b
lea dx,ruta
int 21h
mov handle,ax
jc ErrorAbrir
endm

cerrarF macro handle
mov ah,3eh
mov handle,bx
int 21h
endm

leerF macro numbytes,buffer,handle
mov ah,3fh
mov bx,handle
mov cx,numbytes
lea dx,buffer
int 21h
jc ErrorLeer
endm

crearF macro buffer,handle
mov ah,3ch
mov cx,00h
lea dx,buffer
int 21h
mov handle,ax
jc ErrorCrear
endm

escribirF macro numbytes,buffer,handle
	mov ah, 40h
	mov bx,handle
	mov cx,numbytes
	lea dx,buffer
	int 21h
	jc ErrorEscribir
endm

