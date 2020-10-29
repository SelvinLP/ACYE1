juego macro
local jinicio
xor cx,cx
xor si,si
xor di,di ;contador del tiempo
mov bloq1,2
mov bloq2,9
mov bloq3,16
mov bloq4,23
mov bloq5,30
mov bloq6,2
mov bloq7,9
mov bloq8,16
mov bloq9,23
mov bloq10,30
mov pospelotax,20
mov pospelotay,20
mov dirperlotax,1
mov dirperlotay,0
mov posjugador1 ,15
mov posjugador2 ,20
mov ax,cx
ConvertirString tempuntos
mov ax,si
ConvertirString temtiempo
Modografico
pintar_bloque 22,posjugador1,22,posjugador2,15
print temusuario,0,0,15
print temnivel,13,0,15

jjinicio:
	;Encabezado
	mov ax,cx
	ConvertirString tempuntos
	mov ax,si
	ConvertirString temtiempo
	print tempuntos,24,0,15
	print temtiempo,34,0,15
	;movimientos
	bloquespuntos
	mov teclaguard,4
    mvpelota 
	cmp teclaguard, 3	;Salida en caso de que pierda
		je jsalida
	;guarda si se presiona una tecla
    mov ah, 01h
    int 16h
    jnz Obtenerv 
    jmp jsinicio
Obtenerv:
    obtener_direccion teclaguard
	cmp teclaguard, 3
		je jsalida
	cmp teclaguard, 0
		je mvjugadorpintar
	cmp teclaguard, 1
		je mvjugadorpintar
    jmp jsinicio
mvjugadorpintar:
	mvjugador
	jmp jsinicio
jsinicio:
    Delay 400
	add di,1
	cmp di,10
		je inctiempo
	jmp jjinicio
inctiempo:
	xor di,di
	add si,1
	jmp jjinicio
jsalida:
Modotexto
endm

bloquespuntos macro
blinicio:
	cmp bloq1,0
		jne pintarblqq1
pintarblqq1:
	pintar_bloque 3,2,3,7,2
	cmp bloq2,0
		jne pintarblqq2
	jmp pintarblqq3
pintarblqq2:
	pintar_bloque 3,9,3,14,1
	cmp bloq3,0
		jne pintarblqq3
	jmp pintarblqq4
pintarblqq3:
	pintar_bloque 3,16,3,21,3
	cmp bloq4,0
		jne pintarblqq4
	jmp pintarblqq5
pintarblqq4:
	pintar_bloque 3,23,3,28,4
	cmp bloq5,0
		jne pintarblqq5
	jmp pintarblqq6
pintarblqq5:
	pintar_bloque 3,30,3,35,5
	cmp bloq6,0
		jne pintarblqq6
	jmp pintarblqq7
pintarblqq6:
	pintar_bloque 5,2,5,7,6
	cmp bloq7,0
		jne pintarblqq7
	jmp pintarblqq8
pintarblqq7:
	pintar_bloque 5,9,5,14,7
	cmp bloq8,0
		jne pintarblqq8
	jmp pintarblqq9
pintarblqq8:
	pintar_bloque 5,16,5,21,8
	cmp bloq9,0
		jne pintarblqq9
	jmp pintarblqq10
pintarblqq9:
	pintar_bloque 5,23,5,28,9
	cmp bloq10,0
		jne pintarblqq10
	jmp blsalirp
pintarblqq10:
	pintar_bloque 5,30,5,35,10
blsalirp:
endm

mvjugador macro
mvjinicio:
	pintar_bloque 22,posjugador1,22,posjugador2,0
	cmp teclaguard, 1	;izq
		je movizq
	cmp teclaguard, 0	;der
		je movder
movizq:
	cmp posjugador1, 1
		je mvjsalir
	sub posjugador1, 1
	sub posjugador2, 1
	jmp mvjsalir
movder:
	cmp posjugador2, 38
		je mvjsalir
	add posjugador1, 1
	add posjugador2, 1
	jmp mvjsalir
mvjsalir:
	pintar_bloque 22,posjugador1,22,posjugador2,15
endm

mvpelota macro
pintar_bloque pospelotay,pospelotax,pospelotay,pospelotax,0
mov dl, pospelotax
vlx:
    cmp pospelotax, 38
        je dirX
    cmp pospelotax, 1
        je dirX
    cmp dirperlotax, 1
        je incx
    cmp dirperlotax, 0
        je decx
dirX:
    cmp dirperlotax, 1
        je cambioDaI
    cmp dirperlotax, 0
        je cambioIaD
cambioDaI:
    mov dirperlotax, 0
    jmp decx
cambioIaD:
    mov dirperlotax, 1
    jmp incx
incx:
    add pospelotax, 1
    jmp vly
decx:
    sub pospelotax, 1
    jmp vly
vly:
    cmp pospelotay, 2
        je dirY
	cmp pospelotay, 21
		je mvvjug
    cmp dirperlotay, 1
        je incy
    cmp dirperlotay, 0
        je decy
dirY:
    cmp dirperlotay, 1
        je cambioAaB
    cmp dirperlotay, 0
        je cambioBaA
cambioAaB:
    mov dirperlotay, 0
    jmp decy
cambioBaA:
    mov dirperlotay, 1
    jmp incy
incy:
    add pospelotay, 1
    jmp mvsalir
decy:
    sub pospelotay, 1
    jmp mvsalir
mvjperdio:
	mov teclaguard, 3
	jmp mvsalir
mvvjug:
	mov al, posjugador1
	cmp al, dl
	jle valid2
	jmp mvjperdio
valid2:
	mov al, posjugador2
	cmp dl, al
	jle dirY
	jmp mvjperdio
mvsalir:
pintar_bloque pospelotay,pospelotax,pospelotay,pospelotax,15
endm

pintar_bloque macro line_i, col_i, line_f, col_f, color
	push_registros

	mov bh, color	;color
	mov ch, line_i	;comienzo linea
	mov cl, col_i	;comienzo Columna
	mov dh, line_f	;fin de linea
	mov dl, col_f	;fin de Columna
	mov ah, 06h
	mov al, 0
	int 10h

	pop_registros
endm

Modografico macro 
    ;Modo video
    mov ax, 0013h
    int 10h
endm

Modotexto macro
	mov ax, 0003h
	int 10h
endm

push_registros macro
	push ax
	push bx
	push cx
	push dx
	push si
	push di
endm

pop_registros macro
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
endm

limpiarpantalla macro 
    mov ax, 0013h
	int 10h
	mov ah,0Bh 					 
	mov bh,00h 					 
	mov bl,00h 					 
    int 10h    					 
endm

pixel macro x0, y0, color
	push cx
	mov ah, 0ch
	mov al, color
	mov bh, 00h
	mov dx, y0
	mov cx, x0
	int 10h
	pop cx
endm

print macro char, x, y, color
	local loop_print, fin_print
	
	push_registros

	mov di, 0
	mov dl, x
	mov dh, y

	loop_print:
		mov ah, 02h
		mov bh, 0
		int 10h
		cmp char[di], '$'	;verificamos el fin de cadena
		je fin_print	;si es igual terminamos
		MOV AH,09H		;imprimir en pantalla
		MOV AL, char[di]	;caracter (solo 1 y solo así se puede) a imprimir
		MOV BH,0	;opciones (no se cuales hay xd)
		MOV BL,color 
		MOV CX,1	;numero de repeticiones del mismo caracter
		INT 10H 	;interrupcion y se imprime
		inc di 		;continuamos en la cadena
		inc dl		;para posicionar el cursor
		jmp loop_print 

	fin_print:
		pop_registros				
endm

obtener_direccion macro left
	local RASTREA, derecha, izquierda, SAL1, SAL2, SAL3
	local colocar_pausa
	push_registros
		MOV AH,10h 	;leer teclado expandido los que no estan en ascii
    	INT 16H
    	CMP AL,00H 	;coidgo de rastreo, si es diferente es un asccii
    	JE RASTREA        
    	CMP AL,0E0H ;en algunas pc es este y no el de arrib xd
    	je RASTREA        
    
    JMP SAL2 	;es un asccii
    RASTREA:  
        cmp ah, 04bh
        je izquierda
        cmp ah, 04dh
        je derecha      	
        jmp SAL3	;no es ninguna Flecha

    derecha: 
 		mov left, 0
		jmp SAL1
	izquierda: 
 		mov left, 1
		jmp SAL1

	colocar_pausa:
		mov ah, 10h
        int 16h
		jmp SAL1
	SAL2:
		cmp al, 32
		    je colocar_pausa
		cmp al, 27
		    je SAL3
		jmp SAL1
	SAL3:
		mov left, 3
	SAL1:
	pop_registros
endm
