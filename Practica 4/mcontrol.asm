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


ConvertirString macro buffer
LOCAL Dividir,Dividir2,FinCr3,NEGATIVO,FIN2,FIN
push si 
xor si,si
xor cx,cx
xor bx,bx
xor dx,dx
mov dl,0ah
test ax,1000000000000000
jnz NEGATIVO
jmp Dividir2
NEGATIVO:
	neg ax
	mov buffer[si],45
	inc si
	jmp Dividir2
Dividir:
	xor ah,ah
Dividir2:
	div dl
	inc cx
	push ax
	cmp al,00h
	je FinCr3
	jmp Dividir
FinCr3:
	pop ax
	add ah,30h
	mov buffer[si],ah
	inc si
	loop FinCr3
	mov ah,24h
	mov buffer[si],ah
	inc si
FIN:
pop si
endm

CovertirAscii macro numero
LOCAL INICIO,FIN
push si
xor ax,ax
xor bx,bx
xor cx,cx
mov bx,10	
xor si,si
INICIO:
	mov cl,numero[si] 
	cmp cl,48
	jl FIN
	cmp cl,57
	jg FIN
	inc si
	sub cl,48	
	mul bx		
	add ax,cx	
	jmp INICIO
FIN:
pop si
endm
