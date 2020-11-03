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
    jmp lgadmin
BubbleSort:
    ;Pasar de array a numerros
    pasararray usuypuntos
    ;Grafica
    push ax
    imprimir ingrevel
    obtenerchar
    mov temvelocidad[5], al
    pop ax
    ordbubblesort ordarray, ordBubbleSorttxt
    imprimir generep
    topuntos
    imprimir generepfin
    jmp lgadmin
QuickSort:
    imprimir generep
    topuntos
    imprimir generepfin
    jmp lgadmin
ShellSort:
    imprimir generep
    topuntos
    imprimir generepfin
    jmp lgadmin
toptiempos:
	imprimir tipoordenamiendo
    obtenerchar
	cmp al,49
		je BubbleSort2
	cmp al,50
		je QuickSort2
	cmp al,51
		je ShellSort2
    jmp lgadmin 
BubbleSort2:
    ;Pasar de array a numerros
    pasararray usuytiempo
    ;Grafica
    imprimir generep
    toptime
    imprimir generepfin
    jmp lgadmin
QuickSort2:
    imprimir generep
    toptime
    imprimir generepfin
    jmp lgadmin
ShellSort2:
    imprimir generep
    toptime
    imprimir generepfin
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
local psinicio, psvobtenernum, psvalid, psfin
Limpiararr arrtem
xor cx,cx
xor dx,dx
xor si,si
xor di,di
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
    ;imprimir arrtem
    ;imprimirchar 33
    CovertirAscii arrtem
    mov ordarray[di],al
    Limpiararr arrtem
    xor cx,cx
    inc di
    ;
    ;push si
    ;dec cont
    ;mov cl, cont
    ;mov si, cx
    ;mov al, ordarray[0]
    ;pop si
    ;ConvertirString arrtem
    ;imprimir arrtem
    jmp psinicio
psfin:
mov cont,di
endm

ordbubblesort macro array, titulo
local oloop, iloop, common
;nivel de velocidad
mov dx, cont
oloop:
    push dx
    pintargrafica array, titulo
    pop dx
    mov cx, cont
    lea si, array
iloop:
    mov al, [si]                 ; Because compare can't have both memory
    cmp al, [si+1]
        jl common                      ; if al is less than [si+1] Skip the below two lines for swapping.
    xchg al, [si+1]
    mov [si], al                    ; Coz we can't use two memory locations in xchg directly.
common:
    INC si
    dec cx
    cmp cx,0
        jne iloop
    dec dx
    jnz oloop
endm 

pintargrafica macro arrt, titulo
local pintini, pintfin, pintnumeros
Limpiararr temrepdata
Modografico
pintini:
    ;Titulo
    print titulo, 1, 0,15
    ;Puntos
    print temvelocidad,18,0,15
    pintarborde
    xor di,cont
    jmp pintnumeros
pintnumeros:
    dec di
    ;mov al,arrt[si]
    ;ConvertirString temrepdata
    print temvelocidad,5,20,15 
    xor si,si
    cmp di,si
        jne pintnumeros
    jmp pintfin
pintfin:
    mov ah, 10h
	int 16h
Modotexto
endm




