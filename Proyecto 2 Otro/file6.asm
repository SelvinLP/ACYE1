llenar_variables macro cadena, levels
	
	mov si, 0 ;maneja el indice de la cadena
	mov cx, 0 ;maneja indice nivel
	mov di, 0 ;maneja las cadenas
	mov bx, 0 ;maneja el indice de los niveles
	mov levels, -1
	inicio_leer_nivel:
		cmp cadena[si], 'N'
		je recorrer_cadena
		cmp cadena[si], '$'
		je salir_leer_cadena
		inc si
		jmp inicio_leer_nivel
	recorrer_cadena:
		inc levels
		cmp levels, 6
		jae salir_leer_cadena
		add si, 6
		mov di, 0
	v_nombre:
		mov al, cadena[si]
		cmp al, ';' ; termina el nombre
		je ver_tiempos ;
		;cmp di, 7 ;capacidad para 7 nomas
		;je ver_tiempos
		mov bx, cx ;cx indce en el array
		mov array_nivel[bx], al
		inc si
		inc di
		inc cx
		jmp v_nombre


	ver_tiempos:
		inc si
		
		mov ax, levels
		mov bl, 2
		mul bl
		;inc ax
		mov bx, ax

		mov dl, cadena[si]
		inc si
		mov dh, cadena[si]
		sub dl, '0'
		sub dh, '0'
		mov al, 10
		mul dl
		add al, dh
		xor ah, ah
		mov array_time_nivel[bx], ax

		add si, 2
		mov dl, cadena[si]
		inc si
		mov dh, cadena[si]
		sub dl, '0'
		sub dh, '0'
		mov al, 10
		mul dl
		add al, dh
		xor ah, ah	
		mov array_time_enemi[bx], ax

		add si, 2
		mov dl, cadena[si]
		inc si
		mov dh, cadena[si]
		sub dl, '0'
		sub dh, '0'
		mov al, 10
		mul dl
		add al, dh	
		mov array_time_bonus[bx], ax

		add si, 2
		mov dl, cadena[si]
		inc si
		mov dh, cadena[si]
		sub dl, '0'
		sub dh, '0'
		mov al, 10
		mul dl
		add al, dh	
		mov array_point_enemi[bx], ax

		add si, 2
		mov dl, cadena[si]
		inc si
		mov dh, cadena[si]
		sub dl, '0'
		sub dh, '0'
		mov al, 10
		mul dl
		add al, dh	
		mov array_point_bonus[bx], ax


		mov bx, levels
		add si, 2
		mov dl, cadena[si]
		cmp dl, 'r'
		je color_rojo
		cmp dl, 'v'
		je color_verde
		cmp dl, 'a'
		je color_azul
		mov array_color[bx], 31
		jmp inicio_leer_nivel
		color_rojo:
			mov array_color[bx], 4
			jmp inicio_leer_nivel
		color_verde:
			mov array_color[bx], 2
			jmp inicio_leer_nivel
		color_azul:
			mov array_color[bx], 1
			jmp inicio_leer_nivel
			
		salir_leer_cadena:
			inc levels

endm


verificar_nivel macro tiempo, tiempo_aux, nivel, flag
	local desactive_flag, active_flag, max_niveles

	push_registros

	mov si, nivel
	
	mov ax, tiempo
	sub ax, tiempo_aux
	cmp ax, array_time_nivel[si]
	jae active_flag

	desactive_flag:
		mov flag, 0
		jmp max_niveles
	active_flag:
		mov ax, tiempo
		mov tiempo_aux, ax
		mov flag, 1	
	max_niveles:
		pop_registros

endm

;pos del carro
verificar_puntos macro pos, enemx, enemy, bonx, bony, puntos, flag, pbonus, penemigo
	local chek_bonus, restar_puntos, sumar_puntos, activar_flag
	local des_flag, salir_verificar_puntos
	push ax
	verificar_choque pos, enemx, enemy, flag
	cmp flag, 1
	je restar_puntos

	chek_bonus:
		verificar_choque pos, bonx, bony, flag
		cmp flag, 1
		je sumar_puntos
		jmp des_flag
	restar_puntos:
		mov ax, penemigo
		sub puntos, ax
		cmp puntos, 0
		jle activar_flag
		jmp chek_bonus
	sumar_puntos:
		mov ax, pbonus
		add puntos, ax
		jmp des_flag
	activar_flag:
		mov flag, 1
		jmp salir_verificar_puntos
	des_flag:
		mov flag, 0
	salir_verificar_puntos:
		pop ax
endm


;tiempo global de todo el juego
;my_time var auxiliar para cada objeto
;for_time tiempo necesario para uno nuevo
;tiempo = dw = my_time = for_time
;tipo = color 2=malo 43=bueno
paint_objects macro listax, listay, tipo, tiempo, my_time, for_time
	local ciclye_paintx, siguiente_paint, quitar_de_lista, look_space_for_new
	local crear_nuevo, verificar_new, slair_paint_objects, cambio_time
	push_registros

	mov si, 0
	ciclye_paintx:
		cmp listax[si], '$'
		je siguiente_paint
		pintar_malo listax[si], listay[si], 0
		inc listay[si]
		cmp listay[si], 21
		je quitar_de_lista
		pintar_malo listax[si], listay[si], tipo
	siguiente_paint:
		inc si
		cmp si, 10
		je verificar_new
		jmp ciclye_paintx

	quitar_de_lista:
		mov listax[si], '$'
		mov listay[si], '$'
		jmp siguiente_paint

	cambio_time:
		mov di, 0
		mov ax, tiempo
		mov my_time, ax
	look_space_for_new:
		cmp listax[di], '$'
		je crear_nuevo
		inc di
		jmp look_space_for_new
		
	crear_nuevo:
		num_random number_random
		mov al, number_random
		mov listax[di], al
		mov listay[di], 5
		jmp slair_paint_objects
	verificar_new:
		mov cx, tiempo
		sub cx, my_time
		cmp cx, for_time
		je cambio_time

	slair_paint_objects:

	pop_registros
endm

verificar_choque macro pos_car, listax, listay, flag
	local recorrer_x, siguiente_verficacion, recorrer_y
	local marcar_flag, sin_colision, salir_verificar_choque
	push_registros

	mov si, 0
	mov al, pos_car		
	recorrer_x:
		cmp listax, '$'
		je siguiente_verficacion
		cmp al, listax[si]
		je recorrer_y
	siguiente_verficacion:
		inc si
		cmp si, 10
		je sin_colision
		jmp recorrer_x

	recorrer_y:
		cmp listay[si], 20
		je marcar_flag
		jmp siguiente_verficacion

	marcar_flag:
		mov flag, 1
		jmp salir_verificar_choque
	sin_colision:
		mov flag, 0
	salir_verificar_choque:

	pop_registros
endm

;@indice numero de nivel
;@list_n lista de niveles
;@var_msg variable que se va a imprimir
obtener_nivel macro indice, list_n, var_msg
	local copiar_contenido
	push_registros

	mov ax, indice
	mov bx, 7
	mul bx

	mov si, 0
	mov di, ax ;resultado de la multiplic
	reiniciar_variable var_msg, 0
	copiar_contenido:
		mov dl, list_n[di]
		mov var_msg[si], dl
		inc si
		inc di
		cmp si, 7
		jne copiar_contenido

	pop_registros
endm