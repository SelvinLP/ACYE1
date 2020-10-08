Leerjson macro 
local Salida
push ax
xor si,si
xor dh,dh
Inicio:
    xor cx,cx 
    inc si
    mov dh, arrayescritura[si-1]
    cmp dh, 34
        je DatosPadre ;Encontro "
    jmp Inicio
DatosPadre:
    mov dh, arrayescritura[si]
    push si
    mov si,cx
    mov Objpadre[si],dh
    inc cx
    pop si
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34
        je Ciclo
    jmp DatosPadre
InicioPrim:
    mov dh, arrayescritura[si]
    cmp dh, 34
        je Verificaciontipo ;Encontro "
    jmp Ciclo
Verificaciontipo:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,35   ;Encontro #
        je Digito
    cmp dh,43   ;Encontro +
        je Suma
    cmp dh,45   ;Encontro -
        je Menos
    cmp dh,42   ;Encontro *
        je Mult
    cmp dh,47   ;Encontro /
        je Divis
    cmp dh, 97  ;Posible add
        je Cadenaadd
    cmp dh, 115  ;Posible sub
        je Cadenasub
    cmp dh, 109  ;Posible mult
        je Cadenamult
    cmp dh, 100  ;Posible div
        je Cadenadiv
    cmp dh, 105  ;Posible id
        je Cadenaid
    jmp Ciclo
Digito:
    xor cx,cx
    inc si
    inc si
    inc si
    mov dh, arrayescritura[si]
    jmp Valordigito
Valordigito: ; Toma los digitos
    push si
    mov si,cx
    mov Opera1[si],dh
    inc cx
    pop si
    inc si
    mov dh, arrayescritura[si]
    cmp dh,45 ; -
        je Valordigito
    cmp dh,48 ; 0
        je Valordigito
    cmp dh,49 ; 1
        je Valordigito
    cmp dh,50 ; 2
        je Valordigito
    cmp dh,51 ; 3
        je Valordigito
    cmp dh,52 ; 4
        je Valordigito
    cmp dh,53 ; 5
        je Valordigito
    cmp dh,54 ; 6
        je Valordigito
    cmp dh,55 ; 7
        je Valordigito
    cmp dh,56 ; 8
        je Valordigito
    cmp dh,57 ; 9
        je Valordigito
    cmp dh,44 ; , es que tiene un segundo valor
        je Comproseg
    cmp Estadope[0], 1
        je Operar
    jmp Ciclo
Comproseg:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34
        je SegValor
    jmp Comproseg
SegValor:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,35   ;Encontro #
        je Digito2
    cmp dh,43   ;Encontro +
        je Suma
    cmp dh,45   ;Encontro -
        je Menos
    cmp dh,42   ;Encontro *
        je Mult
    cmp dh,47   ;Encontro /
        je Divis
    cmp dh, 97  ;Posible add
        je Cadenaadd
    cmp dh, 115  ;Posible sub
        je Cadenasub
    cmp dh, 109  ;Posible mult
        je Cadenamult
    cmp dh, 100  ;Posible div
        je Cadenadiv
    cmp dh, 105  ;Posible id
        je Cadenaid
    jmp Ciclo
Digito2:
    xor cx,cx
    inc si
    inc si
    inc si
    mov dh, arrayescritura[si]
    jmp Valordigito2
Valordigito2: ; Toma los digitos
    push si
    mov si,cx
    mov Opera2[si],dh
    inc cx
    pop si
    inc si
    mov dh, arrayescritura[si]
    cmp dh,45 ; -
        je Valordigito2
    cmp dh,48 ; 0
        je Valordigito2
    cmp dh,49 ; 1
        je Valordigito2
    cmp dh,50 ; 2
        je Valordigito2
    cmp dh,51 ; 3
        je Valordigito2
    cmp dh,52 ; 4
        je Valordigito2
    cmp dh,53 ; 5
        je Valordigito2
    cmp dh,54 ; 6
        je Valordigito2
    cmp dh,55 ; 7
        je Valordigito2
    cmp dh,56 ; 8
        je Valordigito2
    cmp dh,57 ; 9
        je Valordigito2
    mov Estadope[0],1
    jmp Operar
Operar:
    cmp al,43
        je Llamasum
    cmp al,45
        je Llamarest
    cmp al,42
        je Llamamul
    cmp al,47
        je Llamadiv
    
    jmp Ciclo
Llamasum:
    pop ax
    Opesuma
    jmp Ciclo
Llamarest:
    pop ax
    Operesta
    jmp Ciclo
Llamamul:
    pop ax
    Opemult
    jmp Ciclo
Llamadiv:
    pop ax
    Opediv
    jmp Ciclo
Suma:
    mov Estadope[0],0
    push ax
    mov ax,43
    inc si
    jmp Ciclo
Menos:
    mov Estadope[0],0
    push ax
    mov ax,45
    inc si
    jmp Ciclo
Mult:
    mov Estadope[0],0
    push ax
    mov ax,42
    inc si
    jmp Ciclo
Divis:
    mov Estadope[0],0
    push ax
    mov ax,47
    inc si
    jmp Ciclo
Id:
    jmp Ciclo
Cadenaadd:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,100
        je Cadenaadd2
    jmp Ciclo
Cadenaadd2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,100
        je Suma
    jmp Ciclo
Cadenasub:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,117
        je Cadenasub2
    jmp Ciclo
Cadenasub2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,98
        je Menos
    jmp Ciclo
Cadenamult:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,117
        je Cadenamult2
    jmp Ciclo
Cadenamult2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,108
        je Mult
    jmp Ciclo
Cadenadiv:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,105
        je Cadenadiv2
    jmp Ciclo
Cadenadiv2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,118
        je Divis
    jmp Ciclo
Cadenaid:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,100
        je Id
    jmp Ciclo

Ciclo:
    xor cx,cx
    inc si
    cmp si, SIZEOF arrayescritura
    	jne InicioPrim

pop ax
endm

Opesuma macro
    push ax
    imprimir Opera1
    imprimirchar 43
    imprimir Opera2
    CovertirAscii Opera1
    mov bx,ax
	push bx
	CovertirAscii Opera2
	pop bx
	add ax,bx
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
    pop ax
endm

Operesta macro
    push ax
    imprimir Opera1
    imprimirchar 45
    imprimir Opera2
    CovertirAscii Opera1
    mov bx,ax
	push bx
	CovertirAscii Opera2
	pop bx
	sub ax,bx
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
    pop ax
endm

Opemult macro
    push ax
    imprimir Opera1
    imprimirchar 42
    imprimir Opera2
    CovertirAscii Opera1
    mov bx,ax
	push bx
	CovertirAscii Opera2
	pop bx
    imul ax
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
    pop ax
endm

Opediv macro
    push ax
    imprimir Opera1
    imprimirchar 47
    imprimir Opera2
    CovertirAscii Opera2
    mov bx,ax
	push bx
	CovertirAscii Opera1
	pop bx
    idiv bx
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
    pop ax
endm
