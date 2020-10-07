
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
lea dx,ingreruta
lea dx,arr
int 21h
endm
