;@user a guardar
;@password a guardar
;@l_user lista de usuarios
;@l_pass lista de password
;@num variable de cantidad de usuarios
guardar_user macro user, pass, l_user, l_pass, num
	local eg_user, eg_pass
	movzx ax, num
	mov bl, 7
	mul bl
	mov di, ax
	mov si, 0 
	mov cx, 7
	eg_user:
		mov al, user[si]
		mov l_user[di], al
		inc si
		inc di
	loop eg_user

	movzx ax, num
	mov bl, 4
	mul bl
	mov di, ax
	mov si, 0 
	mov cx, 4
	eg_pass:
		mov al, pass[si]
		mov l_pass[di], al
		inc si
		inc di
	loop eg_pass
	movzx si, num
	mov puntos[si], 0
	mov tiempos[si], 0
	mov niveles[si], 0
	inc num
endm

;@variable donde se guardara 
;@flag numero maximo de caracteres
ingresar_pass macro variable, flag
	local my_lopp_pass, salir_my_loop_pass, salir_con_error, salir_f
	mov di, 3
	mov si, 0
	my_lopp_pass:
		mov ah, 01H
		int 21h
		cmp al, '0'
		jb salir_con_error
		cmp al, '9'
		ja salir_con_error
		mov variable[si], al
		cmp si, di
		je salir_my_loop_pass
		inc si
		jmp my_lopp_pass
	salir_con_error:
		mov flag, 1
		jmp salir_f
	salir_my_loop_pass:
		mov flag, 0
	salir_f:
endm

;@lista de passwords
;@flag marcar coincidencia o no
;@pos a buscar
;@pass word que se busca
validar_password macro lista, flag, pos, pass
	local cycle_search_password, no_equal, salir_validar_pass
	mov ax, 0
	mov al, pos
	mov bl, 4
	mul bl

	mov si, ax

	mov cx, 4
	mov di, 0
	cycle_search_password:
		mov al, lista[si]
		cmp pass[di], al
		jne no_equal
		inc si
		inc di
	loop cycle_search_password
		mov flag, 1
		jmp salir_validar_pass

	no_equal:
		mov flag, 0
		
	salir_validar_pass:
endm

;@user a validar que no exista
;@lista lista donde se buscara
;@flag 1=existe 0=no existe
;@num numero de usuarios existentes
;@pos numero de posicion en la que se encuentra
;@aux auxiliar para ir comparando cadenas
validar_usuario macro user, lista, flag, num, pos, aux
	local ciclo_busqueda, ciclo_user, marcar_encontrado, salir_validar_user
	local ciclo_comparar, no_igual
	mov pos, 0
	movzx cx, num
	mov si, 0			
	ciclo_busqueda:
		push cx	

		mov cx, 7
		mov di, 0
		ciclo_user:
			mov al, lista[si]
			mov aux[di], al
			inc si
			inc di
		loop ciclo_user		

		mov al, user[0]
		cmp aux[0], al
		jne no_igual

		mov al, user[1]
		cmp aux[1], al
		jne no_igual
		
		mov al, user[2]
		cmp aux[2], al
		jne no_igual

		mov al, user[3]
		cmp aux[3], al
		jne no_igual

		mov al, user[4]
		cmp aux[4], al
		jne no_igual

		mov al, user[5]
		cmp aux[5], al
		jne no_igual

		mov al, user[6]
		cmp aux[6], al
		jne no_igual

		jmp marcar_encontrado

		no_igual:
			inc pos
			pop cx

	loop ciclo_busqueda	

		mov flag, 0
		jmp salir_validar_user
	marcar_encontrado:
		mov flag, 1
	salir_validar_user:
endm 

pausa macro
	mov ah, 01h
	int 21h	
	cmp al, 'j'
	je salir
endm

gotoxy macro x, y
	xor bh, bh
	mov dl, x
	mov dh, y
	mov ah, 02h
	int 10h
endm

limpiar macro color
	mov ax, 0600h
	mov bh, color
	mov cx, 0000h
	mov dx, 184fh
	int 10h
endm

imprime macro arg1
	push_registros
	lea dx, arg1
	mov ah, 09h
	int 21h
	pop_registros
endm

;@variable donde se guardara 
;@numero numero maximo de caracteres
leer_var macro variable, numero
	local my_lopp, salir_my_loop
	mov di, numero
	dec di
	mov si, 0
	my_lopp:
		mov ah, 01H
		int 21h
		cmp al, 13
		je salir_my_loop
		mov variable[si], al
		cmp si, di
		je salir_my_loop
		inc si
		jmp my_lopp
	salir_my_loop:
endm

;@variable me indica la variable a reiniciar
;@indice me dice desde que punto se desea reiniciar
reiniciar_variable macro variable, indice
	local cycle_reboot, out_reboot
	push_registros
	mov si, indice
	cycle_reboot:
		cmp variable[si], '$'
		je out_reboot
		mov variable[si], '$'
		inc si
	jmp cycle_reboot
	out_reboot:
	pop_registros
endm