comandcon macro
push ax
xor si,si
xor cx,cx
comandini:
    imprimir ingrecomand
    Limpiararr cadcomando
    obtenertexto cadcomando
    cmp cadcomando[0],101   ;exit
        je Slcomand
    cmp cadcomando[0],69    ;exit
        je Slcomand 
    cmp cadcomando[3],119   ;show
        je Comandos
    cmp cadcomando[3],87    ;show
        je Comandos
    jmp comandini
Comandos:
    cmp cadcomando[5],109    ;m
        je cadmedia1
    jmp Comandotros
cadmedia1:
    cmp cadcomando[6],101    ;e
        je cadmedia2
    jmp Comandotros
cadmedia2:
    cmp cadcomando[7],100    ;d
        je cadmedia3
    jmp Comandotros
cadmedia3:
    calcmedia2
    imprimir cadresultado
    imprimir Opera1
    jmp comandini
Comandotros:
    showreport
    showid
    jmp comandini
Slcomand:

pop ax
endm

generarp macro
push ax
xor cx,cx
ObtenerDt:
    imprimir ingreruta
    imprimir rutaexport
    Creararchivo rutaexport,handleFichero2
	Abrirarchivo rutaexport,handleFichero2
    ;Comando para escribir
    Escribirarchivo SIZEOF rep1, rep1,handleFichero2    ;encabezado
    Escribirarchivo SIZEOF rep2, rep2,handleFichero2    ;fecha
    lea bx,rep3
    call obtenertiempo
    Escribirarchivo SIZEOF rep3, rep3,handleFichero2    ;Hora
    ;resultados
    Escribirarchivo SIZEOF repres, repres,handleFichero2    ;Reusltados
    calcmedia
    Escribirarchivo SIZEOF remediana, remediana,handleFichero2
    calcmedia
    Escribirarchivo SIZEOF remoda, remoda,handleFichero2
    Escribirarchivo SIZEOF remenor, remenor,handleFichero2
    Escribirarchivo SIZEOF remayor, remayor,handleFichero2

    Escribirarchivo SIZEOF llavedpe, llavedpe,handleFichero2        ;}
    Escribirarchivo SIZEOF rcomillatb, rcomillatb,handleFichero2    ;"
    Escribircara Objpadre
    Escribirarchivo SIZEOF rcomilla, rcomilla,handleFichero2    ;":
    Escribirarchivo SIZEOF rep5, rep5,handleFichero2            ;[
    ;se escriben los id
    Separarid ids
    Escribirarchivo SIZEOF rep6, rep6,handleFichero2            ;]}}
    Cerrararchivo handleFichero2
genesalida:
pop ax
endm

Escribircara macro arr
LOCAL EsCiclopadre, EsSalida
push ax
xor cx,cx
EsCiclopadre:
    mov si,cx
    mov dh, arr[si]
    mov arrtem[0], dh
    inc cx
    push cx
    Escribirarchivo SIZEOF arrtem, arrtem,handleFichero2    
    pop cx
    cmp arr[si+1],36
        je EsSalida
    jmp EsCiclopadre
EsSalida:
pop ax
endm

Separarid macro arr
push ax
xor si,si
xor cx,cx
addllavei:
    push cx
    Escribirarchivo SIZEOF llaveI, llaveI,handleFichero2              ;{
    Escribirarchivo SIZEOF rcomillatb2, rcomillatb2,handleFichero2    ;" 
    pop cx
    jmp Seinicio
Seinicio:
    mov dh, arr[si]
    mov arrtem[0], dh
    inc si
    push cx
    Escribirarchivo SIZEOF arrtem, arrtem,handleFichero2    
    pop cx
    cmp arr[si],36    ;Se sale porque es $
        je Sefin
    cmp arr[si],59    ;Se encontro un ;
        je Buscavalor
    jmp Seinicio
Buscavalor:
    push cx
    Escribirarchivo SIZEOF rcomilla, rcomilla,handleFichero2          ;":
    pop cx
    ;valor
    jmp Valorid
Valorid:
    push si 
    mov si,cx
    cmp valoresu[si],59    ;Se sale porque ;
        je Cerrarid
    mov dh, valoresu[si]
    pop si
    mov arrtem[0], dh
    inc cx
    push cx
    Escribirarchivo SIZEOF arrtem, arrtem,handleFichero2    
    pop cx
    jmp Valorid
Cerrarid:
    pop si
    inc cx
    push cx
    Escribirarchivo SIZEOF llaveD, llaveD,handleFichero2              ;}
    pop cx
    inc si
    cmp arr[si],36    ;Se sale porque es $
        je Sefin
    jmp addllavei
Sefin:
pop ax
endm

showreport macro
local Sl
xor cx,cx
mov si,4
comshow:
    inc si
    mov dh, cadcomando[si]
    cmp dh,36   ;todos son iguales y llama a generar reporte
        je Llamagererar
    push si
    mov si,cx
    inc cx
    mov ah, Objpadre[si]
    pop si
    cmp dh,ah
        je comshow
    jmp Sl
Llamagererar:
    generarp
Sl:
endm

showid macro
local Sl, comshow2, Buscaotroid, Otroid
xor cx,cx
mov arrtem[0],0
xor ax,ax
mov si,4
comshow2:
    inc si
    mov dh, cadcomando[si]
    cmp dh,36   ;todos son iguales y llama a generar reporte
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
        je comshow2
    
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
    mov si,4
    mov dh, arrtem[0]
    inc dh
    mov arrtem[0],dh
    jmp comshow2
mostrarids:
    xor si,si
    xor cx,cx
    imprimir cadresultado
    cmp arrtem[0],0
        je mostarprimero
    jmp Mostarvarios    
mostarprimero:
    mov dh, valoresu[si]
    cmp dh,59
        je Sl
    imprimirchar dh
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
endm

calcmedia macro 
local calcini, Otroval, Masvalores, calmedi, calcdiv, calcsal
xor si,si
xor cx,cx
xor ax,ax
xor bx,bx
mov arrtem[0],1
Limpiararr Opera1
Limpiararr Opera2
calcini:
    mov dh,valoresu[si]
    cmp dh, 59
        je Otroval
    push si
    mov si,cx
    mov Opera1[si], dh
    inc cx
    pop si
    inc si
    jmp calcini
Otroval:
    xor cx,cx
    inc si
    jmp Masvalores
Masvalores:
    mov dh,valoresu[si]
    cmp dh, 59
        je calmedi
    cmp dh, 36
        je calcdiv
    mov dh,valoresu[si]
    push si
    mov si,cx
    mov Opera2[si], dh
    inc cx
    pop si
    inc si
    jmp Masvalores
calmedi:
    mov dh, arrtem[0]
    inc dh
    mov arrtem[0],dh
    xor ax,ax 
    CovertirAscii Opera1
    Limpiararr Opera1
    mov bx,ax
    push bx
    CovertirAscii Opera2
    Limpiararr Opera2
    pop bx
    add ax,bx
    ConvertirString Opera1
    inc si
    jmp Masvalores
calcdiv:
    CovertirAscii Opera1
    xor bx,bx
    mov dh, arrtem[0]
    mov bl,dh
    cwd
    idiv bx
    ConvertirString Opera1
    Escribircara Opera1
    jmp calcsal
calcsal:
endm

calcmedia2 macro 
local calcini, Otroval, Masvalores, calmedi, calcdiv, calcsal
xor si,si
xor cx,cx
xor ax,ax
xor bx,bx
mov arrtem[0],1
Limpiararr Opera1
Limpiararr Opera2
calcini:
    mov dh,valoresu[si]
    cmp dh, 59
        je Otroval
    push si
    mov si,cx
    mov Opera1[si], dh
    inc cx
    pop si
    inc si
    jmp calcini
Otroval:
    xor cx,cx
    inc si
    jmp Masvalores
Masvalores:
    mov dh,valoresu[si]
    cmp dh, 59
        je calmedi
    cmp dh, 36
        je calcdiv
    mov dh,valoresu[si]
    push si
    mov si,cx
    mov Opera2[si], dh
    inc cx
    pop si
    inc si
    jmp Masvalores
calmedi:
    mov dh, arrtem[0]
    inc dh
    mov arrtem[0],dh
    xor ax,ax 
    CovertirAscii Opera1
    Limpiararr Opera1
    mov bx,ax
    push bx
    CovertirAscii Opera2
    Limpiararr Opera2
    pop bx
    add ax,bx
    ConvertirString Opera1
    inc si
    jmp Masvalores
calcdiv:
    CovertirAscii Opera1
    xor bx,bx
    mov dh, arrtem[0]
    mov bl,dh
    cwd
    idiv bx
    ConvertirString Opera1
    jmp calcsal
calcsal:
endm