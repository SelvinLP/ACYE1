toptime macro
local datosto1, totiempofin
push ax
    Creararchivo rutatiempo,handleFichero
	Abrirarchivo rutatiempo,handleFichero
    ;Comando para escribir
    Escribirarchivo SIZEOF repenc, repenc,handleFichero
    Escribirarchivo SIZEOF replimea, replimea,handleFichero
    Escribirarchivo SIZEOF reptoptime, reptoptime,handleFichero
    Escribirarchivo SIZEOF replimea, replimea,handleFichero
    Escribirarchivo SIZEOF reptab, reptab,handleFichero
    Escribirarchivo SIZEOF repencb,repencb,handleFichero
    ;top
    mov auxcont,1
    mov di,cont
datosto1:
 dec di
    mov ax, di
    inc auxcont
    ConvertirString repno
    Escribirarchivo SIZEOF reptab, reptab,handleFichero
    Escribirarchivo SIZEOF repno, repno,handleFichero
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero
    ;valores
    Limpiararr temprint
    mov al,ordarray[di]
    ConvertirString temprint
    obtenervaloresrep usuytiempo, ordarray
    obteneronlyv usuypuntos, temusuario

    Escribirarchivo SIZEOF temusuario, temusuario, handleFichero
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero
    Escribirarchivo SIZEOF temprint, temprint,handleFichero
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero
    Escribirarchivo SIZEOF temrepdata, temrepdata,handleFichero

    xor si,si
    cmp di,si
        jne datosto1
    jmp totiempofin
totiempofin:
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
    mov di,cont
datostop:
    dec di
    mov ax, di
    inc auxcont
    ConvertirString repno
    Escribirarchivo SIZEOF reptab, reptab,handleFichero2
    Escribirarchivo SIZEOF repno, repno,handleFichero2
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero2
    ;valores
    Limpiararr temprint
    mov al,ordarray[di]
    ConvertirString temprint
    obtenervaloresrep usuypuntos, ordarray
    ;obteneronlyv usuytiempo, temusuario

    Escribirarchivo SIZEOF temusuario, temusuario, handleFichero2
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero2
    ;Escribirarchivo SIZEOF temrepdata, temrepdata,handleFichero2
    Escribirarchivo SIZEOF reptabd, reptabd,handleFichero2
    Escribirarchivo SIZEOF temprint, temprint,handleFichero2

    xor si,si
    cmp di,si
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

obteneronlyv macro arr,valor
local obteneronlyvini, obteneronly1, clearrel, cmpusurep, cmpusurep2, repetirrep2, obteneronlyvfin
push di
obteneronlyvini:
    Limpiararr temusuario2
    Limpiararr temrepdata
    xor si,si
    xor di,di
    mov bandcomp,0
    jmp obteneronly1
obteneronly1:
    mov dh,arr[si]
    cmp dh, 58              ;validacion de :
       je clearrel
    cmp dh, 36              ;validacion de $
        je obteneronlyvfin
    mov temusuario2[di],dh
    inc di
    inc si
    jmp obteneronly1
clearrel:
    xor di,di
    inc si
    jmp cmpusurep
cmpusurep:
    mov dh,arr[si]
    cmp dh, 59          ; validacion de ;
        je cmpusurep2
    mov temrepdata[di],dh
    inc di
    inc si
    jmp cmpusurep
cmpusurep2:
    push si
    push cx 
    Comp_cad temusuario2, valor, bandcomp
    pop cx
    pop si
    cmp bandcomp,1
        je obteneronlyvfin
    jmp repetirrep2
repetirrep2:
    Limpiararr temusuario2
    Limpiararr temrepdata
    inc si
    xor di,di
    jmp obteneronly1
obteneronlyvfin:
pop di
endm