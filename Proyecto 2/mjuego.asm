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
mov puntos ,0
Modografico
pintar_bloque 22,posjugador1,22,posjugador2,15
print temusuario,0,0,15
print temnivel,13,0,15
pintarborde

jjinicio:
	;Encabezado
	mov cl, puntos
	mov ax, cx
	ConvertirString tempuntos
	mov ax,si
	ConvertirString temtiempo
	print tempuntos,24,0,15
	print temtiempo,36,0,15
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
;guardamos valores en array
Modotexto
mov ax,si
guardartimeopuntos usuytiempo, ax
imprimir usuytiempo
imprimirchar 33
xor ax,ax
mov al, puntos
guardartimeopuntos usuypuntos, ax
imprimir usuypuntos


endm

bloquespuntos macro
	cmp bloq1,0
		je pintarblqq2
	pintar_bloque 3,2,3,7,2
	jmp pintarblqq2
pintarblqq2:
	cmp bloq2,0
		je pintarblqq3
	pintar_bloque 3,9,3,14,1
	jmp pintarblqq3
pintarblqq3:
	cmp bloq3,0
		je pintarblqq4
	pintar_bloque 3,16,3,21,3
	jmp pintarblqq4
pintarblqq4:
	cmp bloq4,0
		je pintarblqq5
	pintar_bloque 3,23,3,28,4
	jmp pintarblqq5
pintarblqq5:
	cmp bloq5,0
		je pintarblqq6
	pintar_bloque 3,30,3,35,5
	jmp pintarblqq6
pintarblqq6:
	cmp bloq6,0
		je pintarblqq7
	pintar_bloque 5,2,5,7,6
	jmp pintarblqq7
pintarblqq7:
	cmp bloq7,0
		je pintarblqq8
	pintar_bloque 5,9,5,14,7
	jmp pintarblqq8
pintarblqq8:
	cmp bloq8,0
		je pintarblqq9
	pintar_bloque 5,16,5,21,8
	jmp pintarblqq9
pintarblqq9:
	cmp bloq9,0
		je pintarblqq10
	pintar_bloque 5,23,5,28,9
	jmp pintarblqq10
pintarblqq10:
	cmp bloq10,0
		je blsalirp
	pintar_bloque 5,30,5,35,10
	jmp blsalirp	
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
	sub posjugador1, 2
	sub posjugador2, 2
	jmp mvjsalir
movder:
	cmp posjugador2, 38
		je mvjsalir
	add posjugador1, 2
	add posjugador2, 2
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
	;bloques
	cmp pospelotay, 5
		je comprobacionbl1
	cmp pospelotay, 3
		je comprobacionbl2
	jmp cambiodiry
comprobacionbl1:
	validbloqpelota 
	cmp quitarbloque,1
		je dirY
	jmp cambiodiry
comprobacionbl2:
	validbloqpelota2
	cmp quitarbloque,1
		je dirY
	jmp cambiodiry
cambiodiry: 
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

validbloqpelota macro
mov quitarbloque, 0
vlbp6:
	cmp bloq6,0
		jne vl6
	jmp vlbp7
vl6:
	mov al,2
	cmp al,dl
		jnle vlbp7
	mov al,7
	cmp dl,al
		jnle vlbp7
	pintar_bloque 5,2,5,7,0
	mov bloq6,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp7:
	cmp bloq7,0
		jne vl7
	jmp vlbp8
vl7:
	mov al,9
	cmp al,dl
		jnle vlbp8
	mov al,14
	cmp dl,al
		jnle vlbp8
	pintar_bloque 5,9,5,14,0
	mov bloq7,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp8:
	cmp bloq8,0
		jne vl8
	jmp vlbp9
vl8:
	mov al,16
	cmp al,dl
		jnle vlbp9
	mov al,21
	cmp dl,al
		jnle vlbp9
	pintar_bloque 5,16,5,21,0
	mov bloq8,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp9:
	cmp bloq9,0
		jne vl9
	jmp vlbp10
vl9:
	mov al,23
	cmp al,dl
		jnle vlbp10
	mov al,28
	cmp dl,al
		jnle vlbp10
	pintar_bloque 5,23,5,28,0
	mov bloq9,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp10:
	cmp bloq10,0
		jne vl10
	jmp vlbpsalida
vl10:
	mov al,30
	cmp al,dl
		jnle vlbpsalida
	mov al,35
	cmp dl,al
		jnle vlbpsalida
	pintar_bloque 5,30,5,35,0
	mov bloq10,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbpsalida:
endm

validbloqpelota2 macro
mov quitarbloque, 0
vlbp1:
	cmp bloq1,0
		jne vl1
	jmp vlbp2
vl1:
	mov al,2
	cmp al,dl
		jnle vlbp2
	mov al,7
	cmp dl,al
		jnle vlbp2
	pintar_bloque 3,2,3,7,0
	mov bloq1,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp2:
	cmp bloq2,0
		jne vl2
	jmp vlbp3
vl2:
	mov al,9
	cmp al,dl
		jnle vlbp3
	mov al,14
	cmp dl,al
		jnle vlbp3
	pintar_bloque 3,9,3,14,0
	mov bloq2,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp3:
	cmp bloq3,0
		jne vl3
	jmp vlbp4
vl3:
	mov al,16
	cmp al,dl
		jnle vlbp4
	mov al,21
	cmp dl,al
		jnle vlbp4
	pintar_bloque 3,16,3,21,0
	mov bloq3,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp4:
	cmp bloq4,0
		jne vl4
	jmp vlbp5
vl4:
	mov al,23
	cmp al,dl
		jnle vlbp5
	mov al,28
	cmp dl,al
		jnle vlbp5
	pintar_bloque 3,23,3,28,0
	mov bloq4,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbp5:
	cmp bloq5,0
		jne vl5
	jmp vlbpsalida2
vl5:
	mov al,30
	cmp al,dl
		jnle vlbpsalida2
	mov al,35
	cmp dl,al
		jnle vlbpsalida2
	pintar_bloque 3,30,3,35,0
	mov bloq5,0 
	mov quitarbloque, 1
	inc puntos
	jmp vlbpsalida
vlbpsalida2:
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
	push_registros
	mov ah, 0ch
	mov al, color
	mov bh, 00h
	mov dx, y0
	mov cx, x0
	int 10h
	pop_registros
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
		cmp al, 27
			je SAL3
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

pintarborde macro 
push cx
mov cx, 5
bordeA:
	pixel cx,10,15
	inc cx
	cmp cx, 315
		jne bordeA
	mov cx,10
	jmp bordeI
bordeI:
	pixel 5,cx,15
	inc cx
	cmp cx, 195
		jne bordeI
	mov cx,5
	jmp bordeB
bordeB:
	pixel cx,195,15
	inc cx
	cmp cx, 315
		jne bordeB
	mov cx,10
	jmp bordeD
bordeD:
	pixel 315,cx,15
	inc cx
	cmp cx, 195
		jne bordeD
	jmp bordesalida
bordesalida:
pop cx
endm

guardartimeopuntos macro arr, valor
local gtinicio, gtinsertusu, gtcambio, guardato, gtsalir
Limpiararr arrtem
xor si,si
xor cx,cx
xor dx,dx
gtinicio:
	push si
    mov si,cx
    mov dh, arr[si]
    pop si
    cmp dh, 36 ;Valida $
        je gtinsertusu
    inc cx
    jmp gtinicio
gtinsertusu:
	mov dh, temusuario[si]
    cmp dh, 36
        je gtcambio
    push si
    mov si,cx
    mov arr[si],dh
    inc cx
    pop si
    inc si
    jmp gtinsertusu
gtcambio:
	xor si,si
    push si
    mov si,cx
    mov arr[si],58
    inc cx
    pop si
	;pasamos el valor a un array
	mov ax, valor
	push cx
	ConvertirString arrtem
	pop cx
    jmp guardato
guardato:
	mov dh, arrtem[si]
    cmp dh, 36
        je gtsalir
    push si
    mov si,cx
    mov arr[si],dh
    inc cx
    pop si
    inc si
    jmp guardato
gtsalir:
    xor si,si
    push si
    mov si,cx
    mov arr[si],59
    inc cx
    pop si

endm