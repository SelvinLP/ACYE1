toptime macro
push ax
    Creararchivo rutatiempo,handleFichero
	Abrirarchivo rutatiempo,handleFichero
    ;Comando para escribir
    Escribirarchivo SIZEOF repenc, repenc,handleFichero
    Escribirarchivo SIZEOF replimea, replimea,handleFichero
    Escribirarchivo SIZEOF reptoptime, reptoptime,handleFichero
    Escribirarchivo SIZEOF replimea, replimea,handleFichero
    ;top
    Escribirarchivo SIZEOF replimea, replimea,handleFichero
    Cerrararchivo handleFichero
pop ax
endm

topuntos macro
local datostop, topuntosfin,adddi
push ax
    Creararchivo rutapuntos,handleFichero2
	Abrirarchivo rutapuntos,handleFichero2
    ;Comando para escribir
    Escribirarchivo SIZEOF repenc, repenc,handleFichero2
    Escribirarchivo SIZEOF replimea, replimea,handleFichero2
    Escribirarchivo SIZEOF reptoppunt, reptoppunt,handleFichero2
    Escribirarchivo SIZEOF replimea, replimea,handleFichero2
    Escribirarchivo SIZEOF reptab, reptab,handleFichero2
    Escribirarchivo SIZEOF repencb,repencb,handleFichero2
    ;top
    mov auxcont,1
    xor cx,cont
datostop:
    dec cx
    mov ax, auxcont
    inc auxcont
    ConvertirString repno
    Escribirarchivo SIZEOF reptab, reptab,handleFichero2
    Escribirarchivo SIZEOF repno, repno,handleFichero2
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero2
    ;valores
    Limpiararr temprint
    mov di,cx
    mov al,ordarray[di]
    ConvertirString temprint
    push cx
    obtenervaloresrep usuypuntos, ordarray
    pop cx
    Escribirarchivo SIZEOF temusuario, temusuario, handleFichero2
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero2
    Escribirarchivo SIZEOF temprint, temprint,handleFichero2
    cmp cx,0
        jne datostop
    jmp topuntosfin
topuntosfin:
    Escribirarchivo SIZEOF replimea, replimea,handleFichero2
    Cerrararchivo handleFichero2
pop ax
endm

obtenervaloresrep macro arr,valor
local obtenervaloresrepini, obtenervaloresrepfin, obtnume, lgvalidarrep, repetirrep, cleantoprep, comparardata
obtenervaloresrepini:
    Limpiararr temusuario
    Limpiararr temrepdata
    push di
    xor si,si
    xor di,di
    mov bandcomp,0
    jmp obtnume
obtnume:
    mov dh,arr[si]
    cmp dh, 58              ;validacion de :
       je cleantoprep
    cmp dh, 36              ;validacion de $
        je obtenervaloresrepfin
    mov temusuario[di],dh
    inc di
    inc si
    jmp obtnume
cleantoprep:
    xor di,di
    inc si
    jmp lgvalidarrep
lgvalidarrep:
    mov dh,arr[si]
    cmp dh, 59          ; validacion de ;
        je comparardata
    mov temrepdata[di],dh
    inc di
    inc si
    jmp lgvalidarrep
comparardata:
    push si
    push cx 
    imprimirchar 33
    imprimir temrepdata
    imprimirchar 33
    imprimir temprint
    imprimirchar 61
    imprimir temusuario
    Comp_cad temprint, temrepdata, bandcomp
    pop cx
    pop si
    cmp bandcomp,1
        je obtenervaloresrepfin
    jmp repetirrep
repetirrep:
    Limpiararr temusuario
    Limpiararr temrepdata
    inc si
    xor di,di
    jmp obtnume
obtenervaloresrepfin:
pop di
endm