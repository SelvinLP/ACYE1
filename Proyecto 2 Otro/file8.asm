;0=ascendente 1=descendente
shellSort macro lista, tamanio, tipo
	local mientras_1, for_1, mientras_2, shell_ascendente, intercambio
	local fin_for_1, fin_shell, fin_mientras_2
	;tomar tiempo
		mov ah, 2ch ;obtener tiempo inicial
		int 21h ;CH = hour; CL = minute; DH = second; DL = 1/100 second
		
		mov seconds_start, dh 
		mov minutes_start, cl	
		mov var_tiempo, 0
	;fin tomar tiempo
	

	mov si, 0 ; j
	mov di, 0 ; k
	mov bx, 0 ; i
	mov cx, 0 ; intervalo

	movzx ax, tamanio
	mov dl, 2
	div dl

	movzx cx, al ; intervalo = tamanio/2
	mientras_1:
		cmp cx, 0
		je fin_shell
		mov bx, cx
		for_1:
			movzx ax, tamanio		
			cmp bx, ax ; i < tamanio
			jg fin_for_1
						
			mov si, bx ; j = i
			sub si, cx ; j=i-salto
			mientras_2: ;mientras j >=0
				cmp si, 1
				jl fin_mientras_2
				
				mov di, si
				add di, cx ;k=j+intervalo
				;if lista[j]<=lista[k]
				mov al, lista[si]
				mov ah, lista[di]

				cmp tipo, 1
				je shell_ascendente
				cmp al, ah
				jl intercambio
				mov si, -1
				jmp mientras_2
				shell_ascendente:
					cmp al, ah
					jg intercambio
					mov si, -1
					jmp mientras_2
				intercambio:
					mov lista[si], ah
					mov lista[di], al
					graficar_lista lista, msg_shell
					;-----tiempo---------
						obtener_tiempo var_tiempo, minutes_start, seconds_start, tiempo_pausa
						convertir_tiempo var_tiempo, m_tiempo
						print m_tiempo, 17, 1, 7						
					;-----fin tiempo-----
					obtener_hz ah, hz
					;sound hz, 200
					delay_juego velocidad
					;j-=intervalo
					sub si, cx
					jmp mientras_2
																	
			fin_mientras_2:
				inc bx
				jmp for_1

		fin_for_1:
			mov ax, cx
			mov dl, 2
			div dl 
			movzx cx, al ; intervalo = intervalo/2
			jmp mientras_1
	fin_shell:
endm


quickSortA macro tipo_orden, lista_graf, nume_usuarios
	local Mientras, fin0, Fin1, fin_quick
	push_registros
	;tomar tiempo
		mov ah, 2ch ;obtener tiempo inicial
		int 21h ;CH = hour; CL = minute; DH = second; DL = 1/100 second
		
		mov seconds_start, dh 
		mov minutes_start, cl	
		mov var_tiempo, 0
	;fin tomar tiempo

		mov si, sp
		mov tamMin, 1
		movzx ax, nume_usuarios
		;sub ax, 1
		mov tamMax, ax
		push tamMin
		push tamMax
	Mientras:
		cmp sp, si
		je fin_quick
		pop tamMax
		pop tamMin
		partir_asc lista_graf, tipo_orden
		;sound 100, 200
		mov bx, pivot
		dec bx
		cmp bx, tamMin
		jle fin0
		push tamMin
		push bx
	fin0:
		mov bx, pivot
		inc bx
		cmp bx, tamMax
		jge fin1
		push bx
		push tamMax
	Fin1:
		jmp Mientras
	fin_quick:
		graficar_lista lista_graf, msg_quick
		;-----tiempo---------
			obtener_tiempo var_tiempo, minutes_start, seconds_start, tiempo_pausa
			convertir_tiempo var_tiempo, m_tiempo
			print m_tiempo, 17, 1, 7						
		;-----fin tiempo-----
	pop_registros
endm

partir_asc macro arreglo, orden
	local Forr, Mover, fin1_, orden_1, fin_partir
	push_registros
	mov di, tamMax
	mov dl, arreglo[di]
	mov si, tamMin
	dec si
	mov bx, tamMin
	Forr:
		mov cx, tamMax
		dec cx
		cmp bx, cx
		jg fin_partir

	cmp orden, 1
	je orden_1	
		mov cl, arreglo[bx]
		cmp cl, dl
		jl fin1_
	Mover:
		inc si
		xor cx, cx
		mov cl, arreglo[si]
		mov al, arreglo[bx]
		mov arreglo[si], al
		mov arreglo[bx], cl

		graficar_lista arreglo, msg_quick
		;-----tiempo---------
			obtener_tiempo var_tiempo, minutes_start, seconds_start, tiempo_pausa
			convertir_tiempo var_tiempo, m_tiempo
			print m_tiempo, 17, 1, 7						
		;-----fin tiempo-----
		;pausa
		obtener_hz arreglo[si+1], hz
		
		delay_juego velocidad
	fin1_:
		inc bx
		jmp Forr	

	orden_1:
		mov cl, arreglo[bx]
		cmp cl, dl
		jg fin1_	
	jmp Mover

	fin_partir:
		mov cl, arreglo[si+1]
		mov di, tamMax
		mov dl, arreglo[di]
		mov arreglo[si+1], dl
		mov arreglo[di], cl
		xor ch, ch
		;mov valoractual, cx
		inc si
		mov pivot, si
	pop_registros		

endm

;tipo 0=ascendente, 1=desacendente
bubble_sort macro lista, tamnio, tipo
	local ciclo_i, ciclo_j, bubble_ascendente, next_j, next_i, fin_bubble
	local otraxd
	;tomar tiempo
		mov ah, 2ch ;obtener tiempo inicial
		int 21h ;CH = hour; CL = minute; DH = second; DL = 1/100 second
		
		mov seconds_start, dh 
		mov minutes_start, cl	
		mov var_tiempo, 0
	;fin tomar tiempo
	movzx cx, tamnio
	dec cx
	
	mov di, 0
	ciclo_i:		
		cmp di, cx
		jae fin_bubble
		;jmp next_i
		mov si, 1
		ciclo_j:
			movzx dx, tamnio
			sub dx, di
			cmp si, dx
			jae next_i

			mov al, lista[si]
			mov ah, lista[si+1]
			cmp tipo, 1
			je bubble_ascendente
				cmp al, ah
				jae next_j
				mov lista[si], ah
				mov lista[si+1], al
			jmp next_j
			bubble_ascendente:
				cmp al, ah
				jbe next_j
				mov lista[si], ah
				mov lista[si+1], al
			next_j:
				graficar_lista lista, msg_bubble
				;-----tiempo---------
					obtener_tiempo var_tiempo, minutes_start, seconds_start, tiempo_pausa
					convertir_tiempo var_tiempo, m_tiempo
					print m_tiempo, 17, 1, 7						
				;-----fin tiempo-----
				obtener_hz lista[si+1], hz
				;sound hz, 200
				delay_juego velocidad
				inc si
		jmp ciclo_j

		next_i:
			inc di
	jmp ciclo_i		
	fin_bubble:
endm


sound macro hz, tiempo
	push_registros
	mov al, 86h
	out 43h, al
	;mov eax, 1193180
	;mov cx, hz
	;div cx

	mov ax, (1193180 / hz)
	out 42h, al
	mov al, ah
	out 42h, al
	in al, 61h
	or al, 00000011b
	out 61h, al
	delay_juego tiempo
	;apagar
	in al, 61h
	and al, 11111100b
	out 61h, al
	xor eax, eax
	pop_registros
endm

obtener_velocidad macro numero, velocidad
	push ax
	push bx
	mov al, numero
	sub al, '0'
	mov bl, 100
	mul bl
	add ax, 200
	mov velocidad, ax
	pop bx
	pop ax
endm

obtener_hz macro numero, hz
	local rango1_, rango2_, rango3_, rango4_, salir_obtener_hz
	cmp numero, 20
	jbe rango1_
	cmp numero, 40
	jbe rango2_
	cmp numero, 60
	jbe rango3_
	cmp numero, 80
	jbe rango4_
		sound 900, 200
		jmp salir_obtener_hz
	rango1_:
		sound 100, 200
		jmp salir_obtener_hz
	rango2_:
		sound 300, 200
		jmp salir_obtener_hz
	rango3_:
		sound 300, 200
		jmp salir_obtener_hz
	rango4_:
		sound 700, 200
		jmp salir_obtener_hz
	salir_obtener_hz:
endm