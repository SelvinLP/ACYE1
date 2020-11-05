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
