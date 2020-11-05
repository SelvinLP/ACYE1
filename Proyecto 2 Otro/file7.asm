graficar_lista macro lista, titulo
	local ciclo_grafica, mostrar, terminar_graficar
	push_registros
	pintar_bloque 0, 0, 24, 39, 0
	print titulo, 0, 1, 7
	movzx dx, numero_usuarios
	dec dx
	
	espacios_x dl, enx, var_count

	mov var_count2, 0	;maneja col inicial		
	dec enx 		;maneja grosor de linea
	
	xor ah, ah			

	mov al, var_count ;para los bordes var_count
	mov bl, 2
	div bl
	mov var_count, al ;
	add al, ah
	mov var_count4, al ;borde inicial			
		
	pintar_bloque 2, 0, 23, var_count4, 0
				
	mov al, var_count4
	inc al
	mov var_count2, al

	;recorrer lista
	mov cx, 0
	mov di, 1
	ciclo_grafica:
		mov al, var_count2
		add al, enx
		mov var_count3, al 	;maneja la col final
		convertir_8bits points_aux, lista[di]
			mov ah, points_aux[3]
			mov m_puntos_8[1], ah
			mov ah, points_aux[2]
			mov m_puntos_8[0], ah
		print m_puntos_8, var_count2, 22, 7
		cmp lista[di], 0
		je mostrar
		obtener_color lista[di], color
		espacios_y lista[di], altura_max, eny			
		pintar_bloque eny, var_count2, 21, var_count3, color
				
	mostrar:
		add al, 2
		mov var_count2, al
		inc cx
		inc di
		cmp cx, dx
		je terminar_graficar
		cmp cx, 19
		je terminar_graficar
		jmp ciclo_grafica
	terminar_graficar:
		pop_registros
endm

;ordena una lista de mayor a menor
;@lista1 que se ordenará
;@lista2 dependiente
ordenar_lista macro lista1, lista2, num_user
	local e_inicio, e_cambio, e_incremento, mov_user, move_pass
	push_registros
	movzx dx, num_user
	dec dx

	;var_count ;indice de cambios si
	;var_count2 ;indice di

	mov di, 1	
	e_inicio: 
		mov si, di
		inc si
	e_cambio:
		mov al, lista1[di]
		mov ah, lista1[si]
		cmp al, ah
		Jae e_incremento
		;hacer cambio en las listas
		mov lista1[di], ah
		mov lista1[si], al
		;lista dependiente
		mov al, lista2[di]
		mov ah, lista2[si]
		mov lista2[di], ah
		mov lista2[si], al
		;niveles
		mov al, niveles_copy[di]
		mov ah, niveles_copy[si]
		mov niveles_copy[di], ah
		mov niveles_copy[si], al
		;cambio contraseña		

		mov count_di, di
		mov count_si, si

		mov al, 4
		mov bx, count_di
		mul bl
		mov di, ax
		
		mov al, 4
		mov bx, count_si
		mul bl
		mov si, ax

		mov cx, 0
	move_pass:
		mov al, passwords_copy[di]
		mov ah, passwords_copy[si]
		mov passwords_copy[di], ah
		mov passwords_copy[si], al
		inc di
		inc si
		inc cx
		cmp cx, 4
		jne move_pass
		
		;hacer cambios en la lsita usuarios
		
		mov al, 7
		mov bx, count_di
		mul bl
		mov di, ax
		
		mov al, 7
		mov bx, count_si
		mul bl
		mov si, ax

		mov cx, 0
	mov_user:
		mov al, usuarios_copy[di]
		mov ah, usuarios_copy[si]
		mov usuarios_copy[di], ah
		mov usuarios_copy[si], al
		inc di
		inc si
		inc cx
		cmp cx, 7
		jne mov_user

		mov di, count_di
		mov si, count_si


	e_incremento:
		inc si
		movzx bx, num_user
		cmp si, bx
		jnz e_cambio
		inc di
		cmp di, dx
		jnz e_inicio

		mov al, lista1[1]
		mov altura_max, al
	pop_registros
endm

;imprimira los primeros 10 usuarios de las listas
preparar_top macro lista, usuarios_, niveles_
	local termino_lista, normal_fila, siguiente_fila, copiar_fila
	local normal_user, copiar_user, inicio_copias
	push_registros
				  ;0123456789012345678901234567890123
	;linea_top db ' 1.   1234567   3   23', 13, 10, '$'
	mov var_count, 6 ;indice linea_top
	mov var_count2, 7 ;indice user 	
	mov var_count3, 0 ;auxiliar para mover en cadena super
	mov var_count4, 1 ;indice de las posiciones
	mov dx, 0
	mov al, '1' ;posicion cardinal centenas
	mov ah, ' ' ;posicion cardinal decenas
	
	inicio_copias:
		mov linea_top[0], ah
		mov linea_top[1], al
		
		movzx di, var_count4
		mov bl, niveles_[di]
		cmp bl, '$'
		je termino_lista
		add bl, '0'
		mov linea_top[16], bl

		movsx si, lista[di]
		convertir_16bits points_aux, si
		mov bl, points_aux[5]
		mov linea_top[21], bl
		mov bl, points_aux[4]
		mov linea_top[20], bl

		mov si, 6
		mov cx, 0
	copiar_user:
		movzx di, var_count2
		mov bl, usuarios_[di]
		cmp bl, '$'
		jne normal_user
		mov bl, ' '
	normal_user:
		mov linea_top[si], bl
		inc si
		inc var_count2
		inc cx
		cmp cx, 7
	jne copiar_user

	mov si, 0
	copiar_fila:
		mov bl, linea_top[si]
		cmp bl, '$'
		je siguiente_fila
		movzx di, var_count3
		mov cadena_super[di], bl
		inc si
		inc var_count3
		jmp copiar_fila
	siguiente_fila:
		inc dx
		inc al
		cmp al, ':'
		jne normal_fila
		mov al, '0'
		mov ah, '1'
	normal_fila:
		inc var_count4
		cmp dx, 10
		jne inicio_copias
	termino_lista:
		pop_registros
endm

;devuelve la posicion inicial en eje y
;x = numero de altura a buscar
espacios_y macro x, max, numero
	local restar
	push ax
	push bx

	xor ax, ax

	mov al, 20
	mov bl, x
	mul bl 	;se multiplica por la altura maxima de la pantalla

	mov bl, max
	div bl 	;se divide entre el numero maximo de altura

	cmp al, 0
	jne restar
	inc al

	restar:
		dec al 	;se resta 1 para la siguente resta

		mov bl, 21 ;desde donde se inicia a graficar
		sub bl, al ;posicion inicio de graficacion
		mov numero, bl

		pop bx
		pop ax
endm

;x = numero de usuarios 
espacios_x macro x, numero, residuo
	local calculos
	push ax
	push bx

	mov bh, x
	xor ax, ax

	cmp bh, 19
	jbe calculos
	mov bh, 19	
	calculos:
		mov bl, bh
			
		mov al, 39
		sub al, bl
			
		div bl
		mov numero, al
		mov residuo, ah

		pop bx
		pop ax
endm

obtener_color macro numero, color
	local rango1, rango2, rango3, rango4, salir_obtener_color
	cmp numero, 20
	jbe rango1
	cmp numero, 40
	jbe rango2
	cmp numero, 60
	jbe rango3
	cmp numero, 80
	jbe rango4
		mov color, 31
		jmp salir_obtener_color
	rango1:
		mov color, 4
		jmp salir_obtener_color
	rango2:
		mov color, 1
		jmp salir_obtener_color
	rango3:
		mov color, 43
		jmp salir_obtener_color
	rango4:
		mov color, 2
		jmp salir_obtener_color

	salir_obtener_color:
endm
;lista1 se copia en lista2
;numero de bytes por registro
copiar_lista macro lista1, lista2, numero
	local copiando_lista
	mov di, 0
	mov al, numero_usuarios
	mov bl, numero
	mul bl
	copiando_lista:		
		mov dl, lista1[di]
		mov lista2[di], dl
		inc di
		cmp di, ax
		jb copiando_lista
endm