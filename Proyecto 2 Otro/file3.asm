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

modo_grafico macro
	mov ax, 0013h
	int 10h
	;mov ax, 0A000h
	;mov ds, ax
endm

modo_texto macro
	mov ax, 0003h
	int 10h
	;mov ax, @data
	;mov ds, ax
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

pintar_carretera macro op1, op2, velocidad
	local loop_street, saltar, loop_street2
	push cx
	mov var_count, 2
	mov var_count2, 3
	mov cx, 0
	loop_street2:
		pintar_bloque var_count, op1, var_count2, op1, 0
		pintar_bloque var_count, op2, var_count2, op2, 0
		add var_count, 2
		add var_count2, 2
		pintar_bloque var_count, op1, var_count2, op1, 0fh
		pintar_bloque var_count, op2, var_count2, op2, 0fh
		add var_count, 2
		add var_count2, 2
		inc cx
		cmp cx, 6
	jne loop_street2			

	delay_juego velocidad

	mov var_count, 2
	mov var_count2, 3
	mov cx, 0
	loop_street:
		pintar_bloque var_count, op1, var_count2, op1, 0fh
		pintar_bloque var_count, op2, var_count2, op2, 0fh
		add var_count, 2
		add var_count2, 2
		pintar_bloque var_count, op1, var_count2, op1, 0
		pintar_bloque var_count, op2, var_count2, op2, 0
		add var_count, 2
		add var_count2, 2
		inc cx
		cmp cx, 6
	jne loop_street	
	pop cx
endm

;@char cadena a imprimir debe de finalizar '$'
;@x coordenada
;@y coordenada
print macro char, x, y, color
	local loop_print, fin_print
	
	push_registros

	mov di, 0
	mov dl, x
	mov dh, y

	loop_print:
		gotoxy dl, dh 	;posicionamos el cursor
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

;@posicion 1=left,2=centro,3=right en la ventana
;@color1 base del carro
;@color2 llantas
pintar_carrito macro posicion, color1, color2
	local armar_carro, posicionar_centro, posicionar_derecha
	push_registros

	mov var_count, 12
	mov var_count2, 13
	
	mov var_count3, 11
	mov var_count4, 14

	mov al, posicion

	cmp al, 1
	je posicionar_centro
	cmp al, 2
	je posicionar_derecha
	
	jmp armar_carro
	posicionar_centro:
		add var_count, 7
		add var_count2, 7
		add var_count3, 7
		add var_count4, 7
		jmp armar_carro
	posicionar_derecha:
		add var_count, 14
		add var_count2, 14
		add var_count3, 14
		add var_count4, 14		
	armar_carro:
		pintar_bloque 20, var_count, 23, var_count2, color1

		pintar_bloque 21, var_count3, 21, var_count3, color2
		pintar_bloque 21, var_count4, 21, var_count4, color2
		
		pintar_bloque 23, var_count3, 23, var_count3, color2
		pintar_bloque 23, var_count4, 23, var_count4, color2
	
	pop_registros
endm

;@posicion 1=left,2=centro,3=right en la ventana
;color 2 para que sea verde
pintar_malo macro posicion, posy, color
	local armar_malo, position_center, position_right
	push_registros

	mov var_count, 12
	mov var_count2, 13
	
	mov var_count3, 11
	mov var_count4, 14

	mov al, posicion
	cmp al, 1
	je position_center
	cmp al, 2
	je position_right
	jmp armar_malo
	position_center:
		add var_count, 7
		add var_count2, 7
		add var_count3, 7
		add var_count4, 7
		jmp armar_malo
	position_right:
		add var_count, 14
		add var_count2, 14
		add var_count3, 14
		add var_count4, 14		
	armar_malo:		
		mov cl, posy
		

		
		pintar_bloque posy, var_count, posy, var_count, color		
		dec posy

		pintar_bloque posy, var_count4, posy, var_count4, color
		mov al, posy
		dec al

		pintar_bloque al, var_count, posy, var_count2, color

		dec posy
		pintar_bloque posy, var_count3, posy, var_count3, color
		dec posy		
		pintar_bloque posy, var_count2, posy, var_count2, color
		mov posy, cl
	pop_registros
endm

;@posicion 1=left,2=centro,3=right en la ventana
;color = 43 amarillo
pintar_bueno macro posicion, posy, color
	local armar_bueno, center_position, right_position
	push_registros

	mov var_count, 12
	mov var_count2, 13
	
	mov var_count3, 11
	mov var_count4, 14

	mov al, posicion
	cmp al, 1
	je center_position
	cmp al, 2
	je right_position
	jmp armar_bueno
	center_position:
		add var_count, 7
		add var_count2, 7
		add var_count3, 7
		add var_count4, 7
		jmp armar_bueno
	right_position:
		add var_count, 14
		add var_count2, 14
		add var_count3, 14
		add var_count4, 14		
	armar_bueno:
		mov cl, posy
		pintar_bloque posy, var_count, posy, var_count, color		
		dec posy

		pintar_bloque posy, var_count4, posy, var_count4, color
		mov al, posy
		dec al

		pintar_bloque al, var_count, posy, var_count2, color

		dec posy
		pintar_bloque posy, var_count3, posy, var_count3, color
		dec posy		
		pintar_bloque posy, var_count2, posy, var_count2, color
		mov posy, cl
	
	pop_registros
endm