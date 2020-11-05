; Para hoy modulo registrar
.model small
assume ds:dato, cs:codigo, ss:pila
.386
pila segment
	dw 5000 dup(' ')
pila ends

dato segment
	;VARIABLE PARA EL ENCABEZADO
		ENCABEZADO DB 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 13, 10
			   DB 'FACULTAD DE INGENIERIA', 13, 10
			   DB 'CIENCIAS Y SISTEMAS', 13, 10
			   DB 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1', 13, 10
			   DB 'NOMBRE: SELVIN LISANDRO ARAGON PEREZ', 13, 10
			   DB 'CARNET: 201701133', 13, 10
			   DB 'SECCION: A', 13, 10, 13, 10, '$', '%'

		MENU_INICIO DB '1) Ingresar ', 13, 10
			   DB '2) Registrar', 13, 10
			   DB '3) Salir', 13, 10, '$'

		MENU_ADMIN DB '1) Top 10 - puntos ', 13, 10
			   DB '2) Top 10 - tiempo', 13, 10
			   DB '3) Salir', 13, 10, '$'

		MENU_ORDEN DB '1) BubbleSort ', 13, 10
			   DB '2) QuickSort', 13, 10
			   DB '3) ShellSort', 13, 10, '$'
		MENU_TIPO DB '1)  ASCENDENTE ', 13, 10
			   DB '2) DESCENDENTE', 13, 10, '$'
			   
		TOP_PUNTOS DB 13, 10, 'Top 10 - puntos',13, 10, '$'
		TOP_TIEMPOS DB 13, 10, 'Top 10 - tiempos',13, 10, '$'
		TITULO_PUNTOS DB 'CHART - PUNTOS$'
		TITULO_TIEMPOS DB 'CHART - TIEMPOS$'
		
	linea_top db ' 1.   1234567   3   23', 13, 10, '$'

	print_aux db ' ', 13, 10, '$'

	;			 012345678
	usuarios db 'adminAI', 700 dup('$')
	passwords db '4321', 400 dup('$')
	puntos db 0, 100 dup('$')
	tiempos db 0, 100 dup('$')
	niveles db 0, 100 dup('$')
	usuarios_copy db 700 dup('$')
	passwords_copy db 400 dup('$')
	tiempos_copy db 100 dup('$')
	puntos_copy db 100 dup('$')
	niveles_copy db 100 dup('$')

	numero_usuarios db 1
	num_usuarios db 0
	auxiliar db 8 dup('$')
	indice_usuario db 0
	auxiliarw db 8 dup('$')
	varword dw 0
	
	;Mensajes
		mensaje_continuar db 13, 10, 'Presione una tecla para continuar', 13, 10, '$'
		msg_in_user db 13, 10, 'Ingrese usuario (7 caracteres)', 13, 10, '$'
		msg_in_password db 13, 10, 'Ingrese contrase',164,'a numerica', 13, 10, '$'

		msg_error_in_pass db 13, 10,'Solo se permiten numeros',13,10,'$'
		msg_error_user_existe db 13, 10, 'El usuario ya existe', 13, 10, '$'
		msg_exito_guardar db 13, 10, 'Usuario guardado correctamente', 13, 10, '$'
		msg_user_not_found db 13, 10, 'Usuario no registrado', 13, 10, '$'
		msg_pass_incorrect db 13, 10, 'Contrase', 164,'a incorrecta', 13, 10, '$'
		msg_error_no_existe db 13, 10, 'Archivo no encontrado', 13, 10, '$'
		msg_confirmacion_archivo db 13, 10, 'Archivo cargado', 13, 10, '$'
		msg_pedir_speed db 13, 10, 'Ingrese velocidad (0-9)', 13, 10, '$'
	
	opcion db 80 dup('$')
	my_flag db 0,0,0

	name_user db 'usuarios.txt', 0
	arch_puntos db 'puntos.txt', 0
	arch_tiempo db 'tiempo.txt', 0
	
	;variables auxiliares, cualquier uso
	var_count db 0
	var_count2 db 0
	var_count3 db 0
	var_count4 db 0	

	count_si dw 0
	count_di dw 0 

	MENSAJE DB '0123456789$',13, 10,'1',13, 10,'2',13, 10,'3',13, 10,'4',13, 10,'5',13, 10,'6',13, 10,'7',13, 10,'8',13, 10,'9', 13, 10, '$'
	;MENSAJE1 DB 'M','AYOR$'

	MENSAJE0 DB 'FIGURA 1 - PUNTOS$'
				  ;0123456789012345678901234567890123456789
	msg_shell DB  'ShellSort  TIME: 00:00  SPEED: 2$'
	msg_quick DB  'QuickSort  TIME: 00:00  SPEED: 2$'
	msg_bubble DB 'BubbleSort TIME: 00:00  SPEED: 2$'
	
	;Bloques
	bloq1 db ?
	bloq2 db ?
	bloq3 db ?
	bloq4 db ?
	bloq5 db ?
	bloq6 db ?
	bloq7 db ?
	bloq8 db ?
	bloq9 db ?
	bloq10 db ?
	posjugador1 db ?
	posjugador2 db ?

	temnivel db 'N1','$'
	teclaguard db ?
	;variables para llevar conteos
	pospelotax db ?
	pospelotay db ?
	dirperlotax db ?
	dirperlotay db ?

	var_password db 5 dup('$')
	var_user db 'prueba$$', 8 dup('$')
	;			0001234567
	var_nivel db 'nivel 1',8 dup('$')
	var_puntos dw 3
	var_tiempo dw 0
	tiempo_pausa dw 0

	time_enem_aux dw 0
	time_bonus_aux dw 0
	nivel_aux dw 0

	m_puntos db '009$$$'
	m_tiempo db '00:00$$$'
	m_termina db 'JUEGO FINALIZADO$$'
	quitarbloque db ?

	array_nivel db 'patito$', 42 dup('$')
	array_time_nivel dw 60, 7 dup('$')
	array_time_enemi dw  2, 7 dup('$')
	array_time_bonus dw  5, 7 dup('$')
	array_point_enemi dw 2, 7 dup('$')
	array_point_bonus dw 1, 7 dup('$')
	array_color db 2, 7 dup('$') ;4, 2, 1, 31

	indice_nivel dw 0 
	indice_nivelb dw 0
	num_niveles dw 1 ;llenar con los niveles disponibles
	number_random db 0
	seconds_aux db 0
	minutes_aux db 0
	seconds_start db 0
	minutes_start db 0

	points_aux db 7 dup('$')
	m_puntos_8 db 10 dup('$')

	ruta_archivo db 144 dup(0)
	handle dw ?

	cadena_super db 1444 dup('$')

	;graficas
	enx db 0
	eny db 0
	altura_max db 0
	color db 0

	tipo_orden db 1
	hz dw 100
	velocidad dw 2000
	tamMin dw 0
	tamMax dw 0
	pivot dw 0
	
	;Reporte
	repenc db 0ah,'UNIVERSIDAD SAN CARLOS DE GUATEMALA', 0ah,'FACULDAD DE INGENIERIA', 0ah,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 ',
				0ah,'NOMBRE: SELVIN LISANDRO ARAGON PEREZ ',0ah,'CARNET: 201701133 ', 0ah,'SECCION: A '
	replimea db 0ah,'-----------------------------------------------------------------------------------------'
	reptoptime db 0ah,9h,9h,9h,9h,9h,9h,9h,9h,9h,'TOP 10 TIEMPOS'
	reptoppunt db 0ah,9h,9h,9h,9h,9h,9h,9h,9h,9h,'TOP 10 PUNTOS'
dato ends

;------------------------------------------------------
;espacio para incluir las macros
include mvar.asm
include mcontrol.asm
include mvideo.asm
include mjuego.asm
include mverj.asm
include mnivel.asm
include mlista.asm ;Area del administrador
include mord.asm ;ordenamientos
;termina espacio de inclución
;------------------------------------------------------

codigo segment
	main proc far
		mov ax, dato
		mov ds, ax

			leer_archivo name_user, cadena_super, my_flag, handle
			cargar_usuarios_archivo cadena_super, numero_usuarios
		Inicio_programa:
			limpiar 0fh
			gotoxy 0,0
			imprime ENCABEZADO
			imprime MENU_INICIO
			reiniciar_variable opcion, 0
			leer_var opcion, 1
			cmp opcion[0], '1'
			je function_ingresar
			cmp opcion[0], '2'
			je function_registrar
			cmp opcion[0], '3'
			je salir
			jmp Inicio_programa

		;----------------------------------------------------
			;Funcion ingresar
		function_ingresar:
			limpiar 0fh
			gotoxy 0, 0
			reiniciar_variable var_user, 0			
			imprime msg_in_user
			leer_var var_user, 7
			validar_usuario var_user, usuarios, my_flag, numero_usuarios, indice_usuario, auxiliar
			cmp my_flag, 1
			je si_existe
			imprime msg_user_not_found
			pausa
			jmp function_ingresar
			si_existe:
				cmp indice_usuario, 0
				je usuario_administrador
				mov dx, 0
				push dx
				jmp ingresar_password

			usuario_administrador:
				mov dx, 1
				push dx
				jmp ingresar_password

			ingresar_password:
				reiniciar_variable var_password, 0
				imprime msg_in_password
				ingresar_pass var_password, my_flag			
				validar_password passwords, my_flag, indice_usuario, var_password
				cmp my_flag, 1
				je password_correcta
				imprime msg_pass_incorrect
				pausa			
				jmp ingresar_password

			password_correcta:
				pop dx
				cmp dx, 0
				je bloque_iniciar_juego
				jmp bloque_administrador

				;----------------------------------------------------
				;area para el administrador
					bloque_administrador:
						limpiar 0fh
						gotoxy 0, 0
						imprime ENCABEZADO
						imprime MENU_ADMIN

						reiniciar_variable opcion, 0
						leer_var opcion, 1

						;copiar lista 
						copiar_lista usuarios, usuarios_copy, 7
						copiar_lista passwords, passwords_copy, 4
						copiar_lista tiempos, tiempos_copy, 1
						copiar_lista niveles, niveles_copy, 1
						copiar_lista puntos, puntos_copy, 1
						
						cmp opcion[0], '1'
						je etiqueta_top_puntos
						cmp opcion[0], '2'
						je etiqueta_top_tiempo
						cmp opcion[0], '3'
						je Inicio_programa
						pausa
						jmp bloque_administrador

						etiqueta_top_puntos:
							limpiar 0fh
							gotoxy 0, 0
							imprime TOP_PUNTOS
							ordenar_lista puntos_copy, tiempos_copy, numero_usuarios
							reiniciar_variable cadena_super, 0
							preparar_top puntos_copy, usuarios_copy, niveles_copy
							imprime cadena_super

							crear_archivo arch_puntos
							movzx ax, var_count3
							mov varword, ax
							;escribir_archivo arch_tiempo, repenc, sizeof repenc
							;escribir_archivo arch_tiempo, replimea, sizeof replimea
							;escribir_archivo arch_tiempo, reptoppunt, sizeof reptoppunt
							;escribir_archivo arch_tiempo, replimea, sizeof replimea
							escribir_archivo arch_puntos, cadena_super, varword

							pausa
							mov opcion[2], 1
							jmp etiqueta_ordenes
						etiqueta_graficar_puntos:
							modo_grafico
							copiar_lista puntos, puntos_copy, 1
							graficar_lista puntos_copy, TITULO_PUNTOS
							pausa

							mov al, numero_usuarios
							dec al
							mov num_usuarios, al
							mov al, opcion[1]
							
							cmp opcion, '1'
							je graficar_bublesort
							cmp opcion, '2'
							je graficar_quicksort
							jmp graficar_ShellSort
							graficar_bublesort:
								mov msg_bubble[31], al
								bubble_sort puntos_copy, num_usuarios, tipo_orden
								pausa	
								jmp regresar_menu_admin						
							graficar_quicksort:
								mov msg_quick[31], al
								quickSortA tipo_orden, puntos_copy, num_usuarios
								pausa
								jmp regresar_menu_admin
							graficar_ShellSort:
								mov msg_shell[31], al
								shellSort puntos_copy, num_usuarios, tipo_orden
								pausa
						regresar_menu_admin:
							modo_texto
						jmp bloque_administrador
						etiqueta_top_tiempo:
							limpiar 0fh
							gotoxy 0, 0
							imprime TOP_TIEMPOS
							ordenar_lista tiempos_copy, puntos_copy, numero_usuarios
							reiniciar_variable cadena_super, 0
							preparar_top tiempos_copy, usuarios_copy, niveles_copy

							crear_archivo arch_tiempo
							movzx ax, var_count3
							mov varword, ax
							;escribir_archivo arch_tiempo, repenc, sizeof repenc
							;escribir_archivo arch_tiempo, replimea, sizeof replimea
							;escribir_archivo arch_tiempo, reptoptime, sizeof reptoptime
							;escribir_archivo arch_tiempo, replimea, sizeof replimea
							escribir_archivo arch_tiempo, cadena_super, varword

							imprime cadena_super							
							pausa

							mov opcion[2], 0
							jmp etiqueta_ordenes
						etiqueta_graficar_tiempos:
							modo_grafico
							copiar_lista tiempos, tiempos_copy, 1
							graficar_lista tiempos_copy, TITULO_TIEMPOS
							pausa
							
							mov al, numero_usuarios
							dec al
							mov num_usuarios, al
							mov al, opcion[1]

							cmp opcion, '1'
							je graficar_bublesort2
							cmp opcion, '2'
							je graficar_quicksort2
							jmp graficar_ShellSort2
							graficar_bublesort2:
								mov msg_bubble[31], al							
								bubble_sort tiempos_copy, num_usuarios, tipo_orden
								pausa
								jmp regresar_menu_admin
							graficar_quicksort2:
								mov msg_quick[31], al
								quickSortA tipo_orden, tiempos_copy, num_usuarios
								pausa
								jmp regresar_menu_admin
							graficar_ShellSort2:
								mov msg_shell[31], al
								shellSort tiempos_copy, num_usuarios, tipo_orden
								pausa
								jmp regresar_menu_admin
						etiqueta_ordenes:
							limpiar 0fh
							gotoxy 0, 0
							imprime ENCABEZADO
							imprime MENU_ORDEN
							reiniciar_variable opcion, 0
							leer_var opcion, 1

							limpiar 0fh
							gotoxy 0, 0
							imprime ENCABEZADO
							imprime msg_pedir_speed
							leer_var opcion[1], 1							
							obtener_velocidad opcion[1], velocidad

							limpiar 0fh
							gotoxy 0, 0
							imprime ENCABEZADO
							imprime MENU_TIPO
							leer_var tipo_orden, 1
							sub tipo_orden, '0'

							cmp opcion[2], 1
							je etiqueta_graficar_puntos
							jmp etiqueta_graficar_tiempos
				;termina bloque administrador
				;----------------------------------------------------

				;----------------------------------------------------
				;Ingresa el usuario
					bloque_iniciar_juego:
						iniciar_juego var_user
						guardar_resultados_juego
						jmp Inicio_programa
				;termina bloque usuario
				;----------------------------------------------------
			
		;Termina funcion ingresar
		;----------------------------------------------------

		;TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT

		;----------------------------------------------------
		;Funcion registrar
		function_registrar:
			limpiar 0fh
			gotoxy 0,0
			in_user:
				reiniciar_variable var_user, 0
				imprime msg_in_user
				leer_var var_user, 7
				validar_usuario var_user, usuarios, my_flag, numero_usuarios, indice_usuario, auxiliar
				cmp my_flag, 0
				je no_existe
				imprime msg_error_user_existe
				pausa				
				
				jmp function_registrar
			no_existe:
				reiniciar_variable var_password, 0
				imprime msg_in_password
				ingresar_pass var_password, my_flag
				cmp my_flag, 1
				je error_password
				guardar_user var_user, var_password, usuarios, passwords, numero_usuarios
				imprime msg_exito_guardar				

				crear_archivo name_user
				escribir_archivo name_user, usuarios, 35

				jmp return_start
			error_password:
				imprime msg_error_in_pass
				;limpiar 0fh
				;pausa
				jmp no_existe					
		;Termina Funcion registrar
		;----------------------------------------------------


		return_start:
			imprime mensaje_continuar
			mov ah, 01h
			int 21h
			cmp al, 'j'
			je salir
			jmp Inicio_programa


		salir:
			reiniciar_variable cadena_super, 0
			guardar_usuarios_archivo cadena_super, numero_usuarios
			crear_archivo name_user
			escribir_archivo name_user, cadena_super, si

			mov ah, 4ch
			int 21h

	main endp
codigo ends

end main