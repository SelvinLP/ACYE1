Login macro

Limpiararr temusuario
Limpiararr tempass
Inicio:
    imprimir ingreusu
    obtenertexto temusuario
	Comp_cad usuadmin, temusuario, bandcomp
	cmp bandcomp, 1
		je pedirpassadm
	;comprobacion de usuarios
	imprimir ingrepass
    obtenertexto tempass
	cmpusuariolg
	cmp bandcomp, 1
		je mostrarjuego
    jmp lgsalir 
pedirpassadm:
	imprimir ingrepass
    obtenertexto tempass
	Comp_cad passadmin, tempass, bandcomp
	cmp bandcomp, 1
		je lgadmin
	jmp lgsalir
lgadmin:
    imprimir encabezadoadmin
	obtenerchar
    cmp al,49
		je toppuntos
	cmp al,50
		je toptiempos
	cmp al,51
		je lgsalir
    jmp lgadmin
toppuntos:
    imprimir tipoordenamiendo
    obtenerchar
	cmp al,49
		je BubbleSort
	cmp al,50
		je QuickSort
	cmp al,51
		je ShellSort
	;reporte
	;topuntos
    jmp lgadmin
BubbleSort:
    ;Pasar de array a numerros
    push_registros
    pasararray usuypuntos
    pop_registros
    ;ordbubblesort ordarray
    ;Grafica
    jmp lgadmin
QuickSort:
    jmp lgadmin
ShellSort:
    jmp lgadmin
toptiempos:
	;reporte
	;toptime
    jmp lgadmin 
mostrarjuego:
    juego
	jmp lgsalir
lgsalir:
endm

cmpusuariolg macro 
push ax
Limpiararr arrtem
xor cx,cx
xor dx,dx
xor si,si
mov bandcomp,0
lginicio:
    mov dh,ususypass[si]
    cmp dh, 58              ;validacion de :
        je lgvalidar
    cmp dh, 36              ;validacion de $
        je lgsalida
    push si
    mov si,cx
    inc cx
    mov arrtem[si],dh
    pop si
    inc si
    jmp lginicio
lgvalidar:
    push si
    push cx 
    Comp_cad temusuario, arrtem, bandcomp
    pop cx
    pop si
	cmp bandcomp, 1
		je lgverpass
    jmp lgbuscarotroid
lgbuscarotroid:
    inc si
    mov dh,ususypass[si]
    cmp dh, 59              ;validacion de ;
        je lgrepitebusqueda
    jmp lgbuscarotroid
lgrepitebusqueda:
	Limpiararr arrtem
    inc si
    jmp lginicio
lgverpass:
	mov bandcomp,0
	Limpiararr arrtem
    inc si
	jmp lgobtenerpass
lgobtenerpass:
	mov dh,ususypass[si]
    cmp dh, 59              ;validacion de ;
        je lgconfpass
	push si
    mov si,cx
    inc cx
    mov arrtem[si],dh
    pop si
	inc si
	jmp lgobtenerpass
lgconfpass:
	push si
    push cx 
    Comp_cad tempass, arrtem, bandcomp
    pop cx
    pop si
	jmp lgsalida
lgsalida:
pop ax
endm

pasararray macro arr
mov cont, 0
Limpiararr arrtem
xor cx,cx
xor dx,dx
xor si,si
psinicio:
    mov dh,arr[si]
    cmp dh, 58              ;validacion de :
        je psvobtenernum
    cmp dh, 36              ;validacion de $
        je psfin
    inc si
    jmp psinicio
psvobtenernum:
    inc si
    mov dh,arr[si]
    cmp dh, 59              ;validacion de ;
        je psvalid
    push si
    mov si,cx
    mov arrtem[si],dh
    inc cx
    pop si
    jmp psvobtenernum
psvalid:
    CovertirAscii arrtem
    push si
    xor cx,cx
    mov cl, cont
    mov si, cx
    mov ordarray[si],al
    pop si
    Limpiararr arrtem
    xor cx,cx
    inc cont
    jmp psinicio
psfin:
endm

ordbubblesort macro array
mov cl,cont      
dec cx
nextscan:
    pintargrafica array                
    mov bx,cx
    mov si,0 

nextcomp:
    mov al,array[si]
    mov dl,array[si+1]
    cmp al,dl
        jnc noswap 
    mov array[si],dl
    mov array[si+1],al
noswap: 
    inc si
    dec bx
    jnz nextcomp
    dec cx
    cmp cx, 0
        jne nextscan     
endm 

pintargrafica macro arrt
mov teclaguard,4

Modografico
pintini:
    print toppuntostitulo, 10,0,15
    ;pintar numeros
    mov al,arrt[0]
    mov si,cx
    ConvertirString arrtem
    xor cx,si
    print arrtem,12,20,15
    pintarborde
    mov ah, 10h
	int 16h
pintfin:
Modotexto
endm




