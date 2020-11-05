;@tiempo en segundos
;@variable formato 00:00
convertir_tiempo macro tiempo, variable
	push_registros
	mov ax, tiempo
	mov bl, 60

	div bl 	;dividmos dentro de 60
	
	mov bh, ah 	;ah contiene los segundos

	aam	;al contiene los minutos
	add al, '0' 
	add ah, '0'
	mov variable[1], al
	mov variable[0], ah

	mov al, bh
	aam
	add al, '0' 
	add ah, '0'
	mov variable[4], al
	mov variable[3], ah
	pop_registros
endm

;convertir 8 bits a decimal 
;@var vector 4 bytes 1 guarda el signo
;@numero resitro dw
convertir_8bits macro var, numero
	local convertir_negativo, conversion, salir_conversion
	push_registros
	
	movzx ax, numero
	cmp ax, 0
	jl convertir_negativo
	mov var[0], '+'
	conversion:		
		mov bl, 10
		div bl

		add ah, '0'
		mov var[3], ah

		aam
		add ah, '0'
		mov var[1], ah
		add al, '0'
		mov var[2], al

		jmp salir_conversion
	convertir_negativo:
		neg ax
		mov var[0], '-'
		jmp conversion
	salir_conversion:
	pop_registros
endm

;convertir 16 bits a decimal 
;@var vector 6 bytes 1 guarda el signo
;@numero resitro dw
convertir_16bits macro var, numero
	local convertir_negativo, conversion, salir_conversion
	push_registros
	mov ax, numero
	mov var[1], '0'
	cmp ax, 0
	jl convertir_negativo
	mov var[0], '+'
	conversion:
		cwd
		mov bx, 1000
		div bx
		aam
		mov cx, dx ;guardamos en cx el residuo
		add al, 48
		mov var[2], al

		mov ax, cx ;cx tiene el residuo
		cwd
		mov bx, 100
		div bx
		aam
		mov cx, dx
		add al, '0'
		mov var[3], al

		mov ax, cx
		cwd
		mov bx, 10
		div bx
		aam
		mov cx, dx
		add al, '0'
		mov var[4], al

		mov ax, cx
		aam
		add al, '0'
		mov var[5], al
		jmp salir_conversion
	convertir_negativo:
		neg ax
		mov var[0], '-'
		jmp conversion
	salir_conversion:
	pop_registros
endm

crear_archivo macro nombre
	local crear_fichero, salida_fichero
	crear_fichero:
		mov ah, 3ch
		mov cx, 0
		mov dx, offset nombre
		int 21h
		jc salida_fichero
		mov bx, ax
		mov ah, 3eh
	salida_fichero:
endm

escribir_archivo macro nombre, cadena, num_car
	local error_abrir
	push_registros
	mov ah, 3dh
	mov al, 01h
	mov dx, offset nombre
	int 21h
	jc error_abrir

	mov bx, ax
	mov cx, num_car
	mov dx, offset cadena
	mov ah, 40h
	int 21h
	mov dx, offset cadena
	cmp cx, ax
	jne error_abrir
	mov ah, 3eh
	int 21h
	error_abrir:
	pop_registros
endm

;@ruta ruta y nombre de archivo
;@cadena donde se guardara el contenido del archivo
;handle apuntador
leer_archivo macro ruta, cadena, error_, handle
	local error_abrir, salir_leer_archivo
	local todo_bien_leer_archivo

	push_registros

	mov al, 00h
	mov dx, offset ruta
	mov ah, 3dh
	int 21h
	jc error_abrir

	mov handle, ax

	mov bx, handle
	mov cx, 1444;caracteres que se quieren leer
	mov dx, offset cadena
	mov ah, 3fh
	int 21h

	mov bx, handle
	mov ah, 3eh
	int 21h
	jmp todo_bien_leer_archivo
	
	error_abrir:
		mov error_, 1
		;mov error_[1], 6
		jmp salir_leer_archivo
	todo_bien_leer_archivo:
		mov error_, 0
	salir_leer_archivo:
	pop_registros
endm

;holahol;4321;001;005;6
;tomatex;1234;002;004;5
cargar_usuarios_archivo macro cadena, usuarios_total
	mov si, 0 ;maneja el indice de la cadena
	mov di, 7 ;indice en los usuarios
	mov bx, 0 ;
	mov dx, 4 ;indice de las pass
	mov usuarios_total, 1
	mov var_count, 1 ;numero de usuario

	c_usuarios:
		mov cx, 0
	cargando_usuario:
		mov al, cadena[si]
		mov usuarios[di], al
		inc si
		inc di
		inc cx
		cmp cx, 7
		jne cargando_usuario

	c_password:
		mov cx, 0
		inc si
	cargando_password:
		mov bx, dx
		mov al, cadena[si]
		mov passwords[bx], al
		inc si
		inc dx
		inc cx
		cmp cx, 4
		jne cargando_password
	
	;pasando los puntos
		movzx bx, usuarios_total

		mov cl, 100
		mov al, cadena[si+1]
		sub al, '0'
		mul cl
		mov ch, al

		mov cl, 10
		mov al, cadena[si+2]
		sub al, '0'
		mul cl
		add ch, al

		mov al, cadena[si+3]
		sub al, '0'
		add ch, al

		add si, 4
		mov puntos[bx], ch
	;pasando los tiempos
		mov cl, 100
		mov al, cadena[si+1]
		sub al, '0'
		mul cl
		mov ch, al

		mov cl, 10
		mov al, cadena[si+2]
		sub al, '0'
		mul cl
		add ch, al

		mov al, cadena[si+3]
		sub al, '0'
		add ch, al

		add si, 4
		mov tiempos[bx], ch

	;pasando el niveles
		mov al, cadena[si+1]
		sub al, '0'
		
		add si, 3
		mov niveles[bx], al

		inc usuarios_total

		cmp cadena[si], '$'
		jne c_usuarios


endm

guardar_usuarios_archivo macro cadena, usuarios_total
	
	mov si, 0 ;maneja el indice de la cadena
	mov di, 7 ;indice en los usuarios
	mov bx, 0 ;
	mov dx, 4 ;indice de las pass
	mov var_count, 1 ;numero de usuario	
	siguiente_user:
		mov cx, 0
	copiar_usuarios:
		mov al, usuarios[di]
		mov cadena[si], al
		inc si
		inc di
		inc cx
		cmp cx, 7
		je siguiente_pass
		jmp copiar_usuarios

	siguiente_pass:
		mov cx, 0
		mov cadena[si], ';'
		inc si
	copiar_passwords:
		mov bx, dx
		mov al, passwords[bx]
		mov cadena[si], al
		inc si
		inc dx
		inc cx
		cmp cx, 4
		je siguiente_punto
		jmp copiar_passwords

	siguiente_punto:
		mov cadena[si], ';'
		inc si
		movzx bx, var_count
		convertir_8bits opcion, puntos[bx]
		mov al, opcion[1]
		mov cadena[si], al
		inc si
		mov al, opcion[2]
		mov cadena[si], al
		inc si
		mov al, opcion[3]
		mov cadena[si], al
		inc si

	;copiando el tiempo
		mov cadena[si], ';'
		inc si
		convertir_8bits opcion, tiempos[bx]
		mov al, opcion[1]
		mov cadena[si], al
		inc si
		mov al, opcion[2]
		mov cadena[si], al
		inc si
		mov al, opcion[3]
		mov cadena[si], al
		inc si

	;copiando los niveles
		mov cadena[si], ';'
		inc si
		convertir_8bits opcion, niveles[bx]
		mov al, opcion[3]
		mov cadena[si], al
		inc si
		mov cadena[si], 13
		inc si

		inc var_count	
		mov al, usuarios_total	
		cmp var_count, al
		jb siguiente_user
endm
