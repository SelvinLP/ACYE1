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

reiniciar_objetos macro
	local reiniciando
	push si
	mov si, 0
	reiniciando:
		mov enemigo_x[si], '$'
		mov enemigo_y[si], '$'
		mov bonus_x[si], '$'
		mov bonus_y[si], '$'
		inc si
		cmp si, 10
	jne reiniciando
	pop si
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

	mov my_flag, 0
	cmp al, 32
	je salir_juego
	cmp al, 27
	jne poner_pausa
	jmp salir_tecla_especial
	salir_juego:
		mov my_flag, 1
	salir_tecla_especial:
		mov ax, tiempo_pausa
		obtener_tiempo tiempo_pausa, minutes_aux, seconds_aux, 0
		add tiempo_pausa, ax
	pop ax
endm

verificar_mov_car macro posicion_car, posicion_car_aux
	local verificar_izq, verificar_der, continue_verificar
	push ax
	obtener_direccion posicion_car_aux
	mov al, posicion_car_aux
		
	cmp al, 1
	je verificar_izq
	cmp al, 0
	je verificar_der
	jmp continue_verificar

	verificar_izq:
		cmp posicion_car, 0
		je continue_verificar
		pintar_carrito posicion_car, 0, 0
		dec posicion_car
		jmp continue_verificar

	verificar_der:
		cmp posicion_car, 2
		je continue_verificar
		pintar_carrito posicion_car, 0, 0
		inc posicion_car
	
	continue_verificar:
	pop ax
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
        jmp SAL3	;no es ninguna Flecha

    derecha: 
 		mov left, 0
		jmp SAL1
	izquierda: 
 		mov left, 1
		jmp SAL1

	colocar_pausa:
		tecla_especial
		jmp SAL3
	SAL2:
		cmp al, 27
		je colocar_pausa
		
	SAL3:
		mov left, 4
	SAL1:
	pop_registros
endm