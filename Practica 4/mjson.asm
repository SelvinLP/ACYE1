Leerjson macro 
push ax
xor si,si
xor dh,dh
xor ax,ax
Inicio:
    xor cx,cx 
    inc si
    mov dh, arrayescritura[si-1]
    cmp dh, 34
        je DatosPadre ; Encontro "
    jmp Inicio
DatosPadre:
    mov dh, arrayescritura[si]
    push si
    mov si,cx
    mov rutaexport[si],dh
    mov Objpadre[si],dh
    inc cx
    pop si
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34
        je Itera ; Encontro "
    jmp DatosPadre
Itera:
    ;datos para la ruta
    push si
    mov si,cx
    mov rutaexport[si],46
    mov rutaexport[si+1],106
    mov rutaexport[si+2],115
    mov rutaexport[si+3],111
    mov rutaexport[si+4],00h
    pop si
    inc si
    jmp InicioPrim
InicioPrim:
    ;buscamos primer id 
    xor cx,cx
    inc si
    mov dh, arrayescritura[si-1]
    cmp dh, 34
        je Primid ; Encontro "
    jmp InicioPrim
Primid:
    mov dh, arrayescritura[si]
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],dh
    inc cx
    mov cont[0],cl
    pop si
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34
        je LMetodo ; Encontro "
    jmp Primid
LMetodo:
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],59
    inc cx
    mov cont[0],cl
    pop si
    xor cx,cx
    inc si
    BucleRecono
    ;imprimir Objpadre
    ;imprimirchar 10
    ;imprimir ids
    ;imprimirchar 10
    ;imprimir valoresu
    ;imprimirchar 10
pop ax
endm

Opesuma macro
    pop ax
    mov bx,ax
	pop ax
	add ax,bx
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
endm

Operesta macro
    pop ax
    mov bx,ax
	pop ax
	sub ax,bx
    neg ax
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
endm

Opemult macro
    pop ax
    mov bx,ax
	pop ax
    imul bl
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
endm

Opediv macro
    pop ax
    mov bx,ax
	pop ax
    cwd
    idiv bx
    ConvertirString Opera2
    imprimirchar 61
    imprimir Opera2
    imprimirchar 10
endm

BucleRecono macro
xor ax,ax
push ax
Iniciocl:
    mov dh, arrayescritura[si]
    cmp dh, 34
        je Binicio ;Encontro "
    jmp Ciclo
Binicio:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,35   ;Encontro #
        je Digito
    cmp dh,43   ;Encontro +
        je Suma
    cmp dh,45   ;Encontro -
        je Resta
    cmp dh,42   ;Encontro *
        je Mult
    cmp dh,47   ;Encontro /
        je Divis
    cmp dh, 97  ;Posible add
        je Cadenaadd
    cmp dh, 65  ;Posible add
        je Cadenaadd
    cmp dh, 115  ;Posible sub
        je Cadenasub
    cmp dh, 83   ;Posible sub
        je Cadenasub
    cmp dh, 109  ;Posible mul
        je Cadenamult
    cmp dh, 77   ;Posible mul
        je Cadenamult
    cmp dh, 100  ;Posible div
        je Cadenadiv
    cmp dh, 68  ;Posible div
        je Cadenadiv
    cmp dh, 73  ;Posible id 
        je Cadenaid
    cmp dh, 105  ;Posible id 
        je Cadenaid
    jmp Idguar
Suma:
    mov ax,43
    push ax
    xor ax,ax
    inc si
    jmp Ciclo
Resta:
    mov ax,45
    push ax
    xor ax,ax
    inc si
    jmp Ciclo
Mult:
    mov ax,42
    push ax
    xor ax,ax
    inc si
    jmp Ciclo
Divis:
    mov ax,47
    push ax
    xor ax,ax
    inc si
    jmp Ciclo
VId:
    ;Obtener el valor del id
    inc si 
    inc si
    inc si
    mov dh, arrayescritura[si]
    Limpiararr Opera1
    valid
    inc si
    mov dh, arrayescritura[si]
    cmp dh,44 ; , es que tiene un segundo valor
        je Operacio2
    jmp Guardarval
Cadenaadd:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,100
        je Cadenaadd2
    cmp dh,68
        je Cadenaadd2
    jmp Noadd
Noadd:
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],97
    inc cx
    mov cont[0],cl
    pop si
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],dh
    inc cx
    mov cont[0],cl
    pop si
    inc si
    mov dh, arrayescritura[si]
    jmp Idguar
Cadenaadd2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,100
        je Suma
    cmp dh,68
        je Suma
    jmp Ciclo
Cadenasub:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,117
        je Cadenasub2
    cmp dh,85
        je Cadenasub2
    jmp Nosub
Nosub:
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],115
    inc cx
    mov cont[0],cl
    pop si
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],dh
    inc cx
    mov cont[0],cl
    pop si
    inc si
    mov dh, arrayescritura[si]
    jmp Idguar
Cadenasub2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,98
        je Resta
    cmp dh,66
        je Resta
    jmp Ciclo
Cadenamult:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,117
        je Cadenamult2
    cmp dh,85
        je Cadenamult2
    jmp nomul
nomul:
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],109
    inc cx
    mov cont[0],cl
    pop si
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],dh
    inc cx
    mov cont[0],cl
    pop si
    inc si
    mov dh, arrayescritura[si]
    jmp Idguar
Cadenamult2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,108
        je Mult
    cmp dh,76
        je Mult
    jmp Ciclo
Cadenadiv:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,105
        je Cadenadiv2
    cmp dh,73
        je Cadenadiv2
    jmp nodiv
nodiv:
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],100
    inc cx
    mov cont[0],cl
    pop si
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],dh
    inc cx
    mov cont[0],cl
    pop si
    inc si
    mov dh, arrayescritura[si]
    jmp Idguar
Cadenadiv2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,118
        je Divis
    cmp dh,86
        je Divis
    jmp Ciclo
Cadenaid:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,68
        je VId
    cmp dh,100
        je VId
    jmp Noid
Noid:
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],105
    inc cx
    mov cont[0],cl
    pop si
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],dh
    inc cx
    mov cont[0],cl
    pop si
    inc si
    mov dh, arrayescritura[si]
    jmp Idguar
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
        je Operacio2
    jmp Guardarval
Guardarval:
    CovertirAscii Opera1
    Limpiararr Opera1
    push ax
    ;Se guardo valor 1
    jmp Ciclo
Operacio2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34
        je SegValor
    jmp Operacio2
Segvalor:
    CovertirAscii Opera1
    Limpiararr Opera1
    push ax
    ;Se guardo valor 1
    inc si
    mov dh, arrayescritura[si]
    cmp dh,35   ;Encontro #
        je Digito2
    jmp Salidarepetir
Digito2:
    xor cx,cx
    inc si
    inc si
    inc si
    mov dh, arrayescritura[si]
    jmp Valordigito2
Valordigito2: ; Toma los digitos 2
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
    jmp Operar
Operar:
    pop ax
    ConvertirString Opera1
    imprimir Opera1
    pop ax
    imprimirchar al
    imprimir Opera2
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
    CovertirAscii Opera2
    Limpiararr Opera2
    push ax
    CovertirAscii Opera1
    Limpiararr Opera1
    push ax
    Opesuma
    pop ax
    cmp al,0
        je Ciclo
    jmp Posibleoperec
Llamarest:
    CovertirAscii Opera2
    Limpiararr Opera2
    push ax
    CovertirAscii Opera1
    Limpiararr Opera1
    push ax
    Operesta
    pop ax
    cmp al,0
        je Ciclo
    jmp Posibleoperec
Llamamul:
    CovertirAscii Opera2
    Limpiararr Opera2
    push ax
    CovertirAscii Opera1
    Limpiararr Opera1
    push ax
    Opemult
    pop ax
    cmp al,0
        je Ciclo
    jmp Posibleoperec
Llamadiv:
    CovertirAscii Opera1
    Limpiararr Opera1
    push ax
    CovertirAscii Opera2
    Limpiararr Opera2
    push ax
    Opediv
    pop ax
    cmp al,0
        je Ciclo
    jmp Posibleoperec
Posibleoperec:
    mov dl,al
    cmp dl,43 ;+
        je Pidenum
    cmp dl,45 ;-
        je Pidenum
    cmp dl,42 ;*
        je Pidenum
    cmp dl,47 ;/
        je Pidenum
    push ax
    jmp Operar
Salidarepetir:
    ; llama otravez al metodo
    dec si
    jmp Binicio
Pidenum:
    ;guardamos valor
    push ax
    CovertirAscii Opera2
    Limpiararr Opera2
    push ax
    xor cx,cx
    jmp Termin2
Termin2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh, 34
        je Tipo2 ;Encontro "
    jmp Termin2
Tipo2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,35   ;Encontro #
        je ObDigito
    cmp dh, 73  ;Posible id 
        je Cadenaid2
    cmp dh, 105  ;Posible id 
        je Cadenaid2
    jmp Ciclo
Cadenaid2:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,68
        je obvalorid2
    cmp dh,100
        je obvalorid2
    jmp Ciclo
obvalorid2:
    ;Obtener el valor del id
    inc si 
    inc si
    inc si
    mov dh, arrayescritura[si]
    Limpiararr Opera2
    valid2
    inc si
    jmp Operar
ObDigito:
    xor cx,cx
    inc si
    inc si
    inc si
    mov dh, arrayescritura[si]
    jmp Valordigitoter
Valordigitoter:
    push si
    mov si,cx
    mov Opera2[si],dh
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
    jmp Operar

Idguar:
    mov dh, arrayescritura[si]
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],dh
    inc cx
    mov cont[0],cl
    pop si
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34
        je Guardoid ; Encontro "
    jmp Idguar
Guardoid:
    ;Guardo valor anterior
    guardarv
    push si
    mov cl,cont[0]
    mov si,cx
    mov ids[si],59
    inc cx
    mov cont[0],cl
    pop si
    Limpiararr Opera2
    xor ax,ax
    push ax
    jmp Ciclo
Ciclo:
    xor cx,cx
    inc si
    cmp si, SIZEOF arrayescritura
    	jne Iniciocl
;Guardo el ultimo valor
guardarv
endm

guardarv macro 
LOCAL guarini, guasalir
push si
xor si,si
xor cx,cx
guarini:
    mov dh,Opera2[si]
    cmp dh,36
        je guasalir
    push si
    mov cl,contval[0]
    mov si,cx
    mov valoresu[si],dh
    inc cx
    mov contval[0],cl
    pop si
    inc si
    
    jmp guarini
guasalir:
    push si
    mov cl,contval[0]
    mov si,cx
    mov valoresu[si],59
    inc cx
    mov contval[0],cl
    pop si
pop si
endm

valid macro
Local ini, Buscaotroid, Otroid, mostrarids, mostarprimero, Mostarvarios, Puntoinc, Sl
xor cx,cx
mov arrtem[0],0
xor ax,ax
ini:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34   ;todos son iguales y llama a generar reporte
        je mostrarids
    push si
    mov si,cx
    inc cx
    mov ah, ids[si]
    pop si
    cmp ah, 59
        je Otroid
    cmp ah, 36
        je Sl
    cmp dh,ah
        je ini
    
    jmp Buscaotroid
Buscaotroid:
    push si
    mov si,cx
    inc cx
    mov ah, ids[si]
    pop si
    cmp ah, 59
        je Otroid
    cmp ah, 36
        je Sl
    jmp Buscaotroid
Otroid:
    mov dh, arrtem[0]
    inc dh
    mov arrtem[0],dh
    jmp ini
mostrarids:
    push si
    xor si,si 
    xor cx,cx
    cmp arrtem[0],0
        je mostarprimero
    jmp Mostarvarios    
mostarprimero:
    mov dh, valoresu[si]
    cmp dh,59
        je Sl

    push si
    mov si,cx
    inc cx
    mov Opera1[si],dh
    pop si

    inc si
    jmp mostarprimero
Mostarvarios:
    mov dh, valoresu[si]
    inc si
    cmp dh,59
        je Puntoinc
    jmp Mostarvarios
Puntoinc:
    mov dh, arrtem[0]
    dec dh
    mov arrtem[0],dh
    cmp arrtem[0],0
        je mostarprimero
    jmp Mostarvarios
Sl:
pop si
endm

valid2 macro
Local ini, Buscaotroid, Otroid, mostrarids, mostarprimero, Mostarvarios, Puntoinc, Sl
xor cx,cx
mov arrtem[0],0
xor ax,ax
ini:
    inc si
    mov dh, arrayescritura[si]
    cmp dh,34   ;todos son iguales y llama a generar reporte
        je mostrarids
    push si
    mov si,cx
    inc cx
    mov ah, ids[si]
    pop si
    cmp ah, 59
        je Otroid
    cmp ah, 36
        je Sl
    cmp dh,ah
        je ini
    
    jmp Buscaotroid
Buscaotroid:
    push si
    mov si,cx
    inc cx
    mov ah, ids[si]
    pop si
    cmp ah, 59
        je Otroid
    cmp ah, 36
        je Sl
    jmp Buscaotroid
Otroid:
    mov dh, arrtem[0]
    inc dh
    mov arrtem[0],dh
    jmp ini
mostrarids:
    push si
    xor si,si 
    xor cx,cx
    cmp arrtem[0],0
        je mostarprimero
    jmp Mostarvarios    
mostarprimero:
    mov dh, valoresu[si]
    cmp dh,59
        je Sl

    push si
    mov si,cx
    inc cx
    mov Opera2[si],dh
    pop si

    inc si
    jmp mostarprimero
Mostarvarios:
    mov dh, valoresu[si]
    inc si
    cmp dh,59
        je Puntoinc
    jmp Mostarvarios
Puntoinc:
    mov dh, arrtem[0]
    dec dh
    mov arrtem[0],dh
    cmp arrtem[0],0
        je mostarprimero
    jmp Mostarvarios
Sl:
pop si
endm