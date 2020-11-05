;Archivo para la ejecución del juego
;@usuario nombre a mostrar en pantalla
;@nivel a mostrar vector con todos los niveles
;@puntos para guardar los puntos
;@tiempo para guaradar el tiempo
;@auxiliar variable para llenar los numeros a mostrar 16bits 
iniciar_juego macro usuario
	local continue_, ver_nivel, siguiente_loop, my_loop
	local juego_finaliza, out_text
	
	modo_grafico
	
	
	;-------operaciones iniciales---------------
	
		reiniciar_objetos
		reiniciar_variable points_aux, 0
		mov indice_nivel, 0 ;manejador de los indices del nivel
		mov indice_nivelb, 0
		mov var_tiempo, 0 ;contador de segundos
		mov nivel_aux, 0
		mov var_puntos, 3
		mov my_flag, 0
		mov posicion_car, 1
		mov tiempo_pausa, 0
		mov time_enem_aux, 0
		mov time_bonus_aux, 0
		mov m_puntos[0], '0'
		mov m_puntos[1], '0'
		mov m_puntos[2], '0'
		print m_puntos, 26, 0, 14	
		
		convertir_tiempo var_tiempo, m_tiempo
		print m_tiempo, 35, 0, 14

		obtener_nivel indice_nivelb, array_nivel, m_nivel
		print m_nivel, 13, 0, 14	
	
		print usuario, 0, 0, 14		

		pintar_bloque 2, 1, 23, 5, 3	;left water
		pintar_bloque 2, 6, 23, 8, 6;left ground
		pintar_bloque 2, 9, 23, 9, 7;
			
		pintar_bloque 2, 30, 23, 30, 7;
		pintar_bloque 2, 31, 23, 33, 6;right ground
		pintar_bloque 2, 34, 23, 38, 3;right water		
		
		pintar_carrito posicion_car, array_color[0], 5
	;--------------------------------------------			
		
	mov ah, 10h
	int 16h ;Presionar tecla para empezar
	
	;tomar tiempo
		mov ah, 2ch ;obtener tiempo inicial
		int 21h ;CH = hour; CL = minute; DH = second; DL = 1/100 second
		
		mov seconds_start, dh 
		mov minutes_start, cl	
	;fin tomar tiempo

	my_loop:
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
				;se presiona una tecla
				;aqui también se verifica la pausa
			mov my_flag, 0			
			verificar_mov_car posicion_car, posicion_car_aux
			cmp my_flag, 1
			je juego_finaliza
			
	continue_:
		mov di, indice_nivel
		mov si, indice_nivelb
		
		;--------impresiones en el ciclo-----------
		;nivel
			obtener_nivel indice_nivelb, array_nivel, m_nivel
			print m_nivel, 13, 0, 14	
		;fin impresion nivel 
		;wall points
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

			verificar_puntos posicion_car, enemigo_x, enemigo_y, bonus_x, bonus_y, var_puntos, my_flag, array_point_bonus[di], array_point_enemi[di]
			cmp my_flag, 1
			je juego_finaliza			
		;fin de puntos

		;figuras
			;imprimir los enemigos
			paint_objects enemigo_x, enemigo_y, 2, var_tiempo, time_enem_aux, array_time_enemi[di]
			
			;imprimir bonus
			paint_objects bonus_x, bonus_y, 43, var_tiempo, time_bonus_aux, array_time_bonus[di]				

			;imprimir carro
			pintar_carrito posicion_car, array_color[si], 5			
		;fin figuras		

		verificar_nivel var_tiempo, nivel_aux, indice_nivel, my_flag
		cmp my_flag, 1
		jne siguiente_loop
			
	ver_nivel:
		inc indice_nivelb
		add indice_nivel, 2
		mov di, indice_nivelb
		cmp di, num_niveles
		jae juego_finaliza
			
	siguiente_loop:
		pintar_carretera 23, 16, 400		
		delay_juego 250
		jmp my_loop

	juego_finaliza:
		pintar_bloque 2, 0, 25, 39, 0
		print m_termina, 10, 10, 14		
	out_text:			
		mov ah, 10h
		int 16h
		modo_texto
endm
