;@lista que se tomara para ordenar
;@lista_u usuarios para no perder el orden
;@lista_p passwords
;@lista_e extra 
;@tipo 1=mayor-menor 0=menor-mayor
ordenar_lista macro lista, lista_u, lista_p, lista_e, tipo, num_usuarios
	local inicio_o, cambio_o, incrementeo_o, menor_mayor
	push_registros
	movzx bx, num_usuarios
	dec bx
	mov di, 0

	inicio_o:
		mov si, di
		inc si
	cambio_o:
		mov al, lista[di]	
		mov ah, lista[si]
		
		cmp tipo, 0
		je menor_mayor

		cmp al, ah
		jae incrementeo_o
		;hacer cambios
	menor_mayor:
		cmp al, ah
		jbe incrementeo_o
		;hacer cambios
	incrementeo_o:
		inc si
		cmp si, num_usuarios
		jnz cambio_o
		inc di
		cmp di, bx
		jnz inicio_o



	pop_registros
endm

guardar_resultados_juego macro
	local ver_los_tiempos, salir_guardar_resulatados
	movzx di, indice_usuario
	mov ax, var_puntos
	mov cl, puntos[di]
	
	cmp al, cl
	jb ver_los_tiempos
	mov puntos[di], al
	mov ax, indice_nivelb
	mov niveles[di], al
	ver_los_tiempos:
	mov ax, var_tiempo
	mov ch, tiempos[di]
	cmp al, ch
	jb salir_guardar_resulatados
	mov tiempos[di], al
	salir_guardar_resulatados:

endm

tecla_especial macro 
	local poner_pausa, salir_tecla_especial
	push ax
	
	mov ah, 2ch ;obtener tiempo inicial
	int 21h ;CH = hour; CL = minute; DH = second; DL = 1/100 second
	
	mov seconds_aux, dh 
	mov minutes_aux, cl

	poner_pausa:
		mov ah, 01h
		int 16h
		jz poner_pausa

	mov ah, 00h
	int 16h

	cmp al, 32
	je salir_juego
	cmp al, 27
	jne poner_pausa
	jmp salir_tecla_especial
	salir_juego:
		mov teclaguard, 4
	salir_tecla_especial:
		mov ax, tiempo_pausa
		obtener_tiempo tiempo_pausa, minutes_aux, seconds_aux, 0
		add tiempo_pausa, ax
	pop ax
endm


mvjugador macro
mvjinicio:
	mov teclaguard, 3
	obtener_direccion teclaguard
	pintar_bloque 22,posjugador1,22,posjugador2,0
	cmp teclaguard, 1	;izq
		je movizq
	cmp teclaguard, 0	;der
		je movder
	jmp mvjsalir
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

obtener_tiempo macro tiempo, min_inico, sec_inicio, time_pausa
	local sin_minutos, salir_obtener_tiempo
	push_registros

	mov ah, 2ch
	int 21h ;CH = hour; CL = minute; DH = second; DL = 1/100 second
	
	mov bh, sec_inicio
	mov bl, min_inico

	mov al, cl ; al = minutos

	sub al, bl ;restamos para saber cuantos minutos han pasado
	cmp al, 0 	
	je sin_minutos
	mov cl, 60 ;obtenemos los segundos de los minutos
	mul cl

	movzx cx, bh
	sub ax, cx ;restamos los segundos iniciales
	movzx cx, dh
	add ax, cx 	;sumamos los segundos actuales
	mov tiempo, ax
	jmp salir_obtener_tiempo
	sin_minutos:
		sub dh, bh
		movzx cx, dh
		mov tiempo, cx
	salir_obtener_tiempo:
		mov cx, time_pausa ;restamos el tiempo de puasa
		sub tiempo, cx 
		pop_registros
endm

num_random macro numero
	local Random, sumar_random, restar_random, out_random
	Random:
		cmp numero, 0
		je sumar_random
		cmp numero, 2
		je restar_random
		dec numero
		jmp out_random

	sumar_random:
		mov numero, 2
		jmp out_random
	restar_random:
		dec numero
	out_random:	
endm

;pausas mientras transcurre el juego
delay_juego macro constante
	local d1, d2, fin
		push si
		push di

		mov si, constante
	d1:
		dec si
		jz fin
		mov di, constante
	d2:		
		dec di
		jnz d2
		jmp d1

	fin:
		pop di
		pop si
endm

;@left vairable donde se guarda la tecla
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
        jmp SAL1	;no es ninguna Flecha

    derecha: 
 		mov left, 0
		jmp SAL1
	izquierda: 
 		mov left, 1
		jmp SAL1

	colocar_pausa:
		tecla_especial
		jmp SAL1
	SAL2:
		cmp al, 27
		je colocar_pausa
		
	SAL3:
		mov left, 3
	SAL1:
	pop_registros
endm