iniciar_juego macro usuario
	local continue_, ver_nivel, siguiente_loop, my_loop
	local juego_finaliza, out_text
	
	modo_grafico
	;-------operaciones iniciales---------------
	xor bx,bx
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
	mov teclaguard,3

	reiniciar_variable points_aux, 0
	mov indice_nivel, 0 ;manejador de los indices del nivel
	mov indice_nivelb, 0
	mov var_tiempo, 0 ;contador de segundos
	mov nivel_aux, 0
	mov var_puntos, 3
	mov my_flag, 0
	mov tiempo_pausa, 0
	mov m_puntos[0], '0'
	mov m_puntos[1], '0'
	mov m_puntos[2], '0'

	pintar_bloque 22,posjugador1,22,posjugador2,15
	print usuario, 0, 0, 14	
	print temnivel,13,0,15
	print m_puntos, 26, 0, 14
	convertir_tiempo var_tiempo, m_tiempo
	print m_tiempo, 35, 0, 14
	pintarborde
	;--------------------------------------------			
		
	mov ah, 10h
	int 16h ;Presionar tecla para empezar
	;tomar tiempo
		mov ah, 2ch ;obtener tiempo inicial
		int 21h ;CH = hour; CL = minute; DH = second; DL = 1/100 second
		
		mov seconds_start, dh 
		mov minutes_start, cl	
	;fin tomar tiempo
		jmp ciclo_j

	ciclo_j:
	;tiempo, min_inico, sec_inicio, time_pausa
	;-----tiempo---------
		obtener_tiempo var_tiempo, minutes_start, seconds_start, tiempo_pausa
		convertir_tiempo var_tiempo, m_tiempo
		print m_tiempo, 35, 0, 14	
	;-----fin tiempo-----		
		
	;Se presonó tecla?
		mov ah, 01h
		int 16h
		jz continue_ ;no se presiona vamos a continue
		mvjugador
		cmp teclaguard, 4	;salida
			je juego_finaliza
		jmp continue_
	continue_:
		convertir_16bits points_aux, var_puntos
		;movzx dx, array_x[3]
		;convertir_16bits points_aux, dx
		;convertir_16bits points_aux, array_time_nivel[di]
		;convertir_16bits points_aux, num_niveles
		mov al, points_aux[5]
		mov m_puntos[2], al
		mov al, points_aux[4]
		mov m_puntos[1], al
		mov al, points_aux[3]
		mov m_puntos[0], al
		print m_puntos, 26, 0, 14	
		bloquespuntos
		mvpelota
		cmp teclaguard, 4	;salida
			je juego_finaliza
		jmp jsinicio

	jsinicio:
		delay_juego 400
		jmp ciclo_j

	juego_finaliza:
	out_text:			
		mov ah, 10h
		int 16h
		modo_texto
endm

pintarborde macro 
local bordeA, bordeI, bordeB, bordeD, bordesalida
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
	mov teclaguard, 4
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
push ax
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
	add var_puntos,5
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
	add var_puntos,5
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
	add var_puntos,5
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
	add var_puntos,5
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
	add var_puntos,5
	jmp vlbpsalida
vlbpsalida:
pop ax
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
	add var_puntos,5
	jmp vlbpsalida2
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
	add var_puntos,5
	jmp vlbpsalida2
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
	add var_puntos,5
	jmp vlbpsalida2
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
	add var_puntos,5
	jmp vlbpsalida2
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
	add var_puntos,5
	jmp vlbpsalida2
vlbpsalida2:
endm