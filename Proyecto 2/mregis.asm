registrousu macro 
push ax
Limpiararr temusuario
Limpiararr tempass
xor cx,cx
rginicio:
    imprimir ingreusu
    obtenertexto temusuario
    cmp cx,8
        jl rgpass
    imprimir errlimit
    jmp rgsalir
rgpass:
    xor cx,cx
    imprimir ingrepass
    obtenertexto tempass
    cmp cx, 5
        jl rgver
    imprimir errlimit
    jmp rgsalir
rgver:
    verfusu temusuario
    cmp bandcomp,0
        je rgguardar
    imprimir errusu
    jmp rgsalir
rgguardar:
    imprimir gdusuario
    guardarusu
    imprimir ususypass
    jmp rgsalir
rgsalir:
pop ax
endm

verfusu macro arr
xor cx,cx
xor dx,dx
xor si,si
mov bandcomp,0
verini:
    mov dh,ususypass[0]
    cmp dh,36   
        je noexiste
    jmp vervarios
vervarios:
    mov dh,ususypass[si]
    cmp dh, 58              ;validacion de :
        je vervalidar
    cmp dh, 36              ;validacion de $
        je versalir
    push si
    mov si,cx
    inc cx
    mov arrtem[si],dh
    pop si
    inc si
    jmp vervarios
vervalidar:
    push si
    push cx 
    Comp_cad arr, arrtem, bandcomp
    pop cx
    pop si
	cmp bandcomp, 1
		je versalir
    jmp buscarotroid
buscarotroid:
    inc si
    mov dh,ususypass[si]
    cmp dh, 59              ;validacion de ;
        je repitebusqueda
    jmp buscarotroid
repitebusqueda:
    Limpiararr arrtem
    inc si
    jmp vervarios
noexiste:
    mov bandcomp,0
    jmp versalir
versalir:
endm

guardarusu macro 
push ax
Limpiararr arrtem
xor si,si
xor cx,cx
xor dx,dx
guarbusq:
    push si
    mov si,cx
    mov dh, ususypass[si]
    pop si
    cmp dh, 36 ;Valida $
        je guariniusu
    inc cx
    jmp guarbusq
guariniusu:
    mov dh, temusuario[si]
    cmp dh, 36
        je guarcambio
    push si
    mov si,cx
    mov ususypass[si],dh
    inc cx
    pop si
    inc si
    jmp guariniusu
guarcambio:
    xor si,si
    push si
    mov si,cx
    mov ususypass[si],58
    inc cx
    pop si
    jmp guarinipass
guarinipass:
    mov dh, tempass[si]
    cmp dh, 36
        je guarsalir
    push si
    mov si,cx
    mov ususypass[si],dh
    inc cx
    pop si
    inc si
    jmp guarinipass
guarsalir:
    xor si,si
    push si
    mov si,cx
    mov ususypass[si],59
    inc cx
    pop si
pop ax
endm