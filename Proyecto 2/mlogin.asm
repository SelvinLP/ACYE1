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
    ordbubblesort ordarray
    topuntos
    jmp lgadmin
QuickSort:
    topuntos
    jmp lgadmin
ShellSort:
    topuntos
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

ordbubblesort macro array
mov dx, cont
oloop:
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

pintargrafica macro arrt
;mov teclaguard,4
;mov temcx,cl
Modografico

pintini:
    mov ah, 10h
	int 16h
pintfin:
Modotexto
;mov cl,temcx
endm




