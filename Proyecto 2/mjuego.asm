juego macro
local jinicio
mov pospelotax,20
mov pospelotay,20
mov dirperlotax,1
mov dirperlotay,1
Modografico
jinicio:
    Modografico
    mvpelota
    in al, 60h 
	mov bl, al
	AND BL, 80H 
	
	cmp AL, 32;salir
	    je jsalida
    jmp jinicio;
jsalida:

Modotexto
endm
; Esperar a tecla
;mov ah, 10h
;int 16h

mvpelota macro
pintar_bloque pospelotay,pospelotax,pospelotay,pospelotax,15
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
    cmp pospelotay, 23
        je dirY
    cmp pospelotay, 1
        je dirY
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
mvsalir:
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

;Guardar una tecla presionada 
    ;in al, 60h 
	;mov bl, al
	;AND BL, 80H 
	
	;cmp AL, 31;salir
	;je FIN
	
	;cmp al, 75;izquierda
	;je IZQUIERDA
		
	;cmp al, 77;derecha
	;je DERECHA