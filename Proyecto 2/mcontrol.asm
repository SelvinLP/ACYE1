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
add cx,1
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

Limpiararr macro arr
Local LCiclo, LSalir
	xor cx,cx
	LCiclo:
	push si
	mov si,cx
	mov arr[si],'$'
	pop si
	inc cx
    cmp cx, SIZEOF arr
    	jne LCiclo
	LSalir:
	xor cx,cx
endm


;-- FECHA Y HORA --
ObtenerFecha macro
mov ah,2ah
int 21h
endm


ObtenerHora macro
mov ah,2ch
int 21h
endm

;Comparacion
Comp_cad macro cad1, cad2, flag
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
	mov flag, 1
	jmp cmpfin
cmpfalse:
	mov flag, 0
	jmp cmpfin 
cmpfin:		
endm

Delay macro constante
local dl1, dl2, dlsalir
push si
push di
mov si,constante
dl1:
	dec si
	jz dlsalir
	mov di,constante
dl2:
	dec di
	jnz dl2
	jmp dl1
dlsalir:
pop di
pop si
endm

Sonido macro
mov al, 86h
out 43h, al
mov ax, (1193180 / hz) ;numero de hz
out 42h, al
mov al, ah
out 42h, al
in al, 00000011b
out 61h, al 
Delay tiempo ; tiempo que queremos que suene
in al, 61h 
and al, 11111100b
out 61h, al
endm