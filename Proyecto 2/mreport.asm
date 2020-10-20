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
push ax
    Creararchivo rutapuntos,handleFichero2
	Abrirarchivo rutapuntos,handleFichero2
    ;Comando para escribir
    Escribirarchivo SIZEOF repenc, repenc,handleFichero2
    Escribirarchivo SIZEOF replimea, replimea,handleFichero2
    Escribirarchivo SIZEOF reptoppunt, reptoppunt,handleFichero2
    Escribirarchivo SIZEOF replimea, replimea,handleFichero2
    ;top
    Escribirarchivo SIZEOF replimea, replimea,handleFichero2
    Cerrararchivo handleFichero2
pop ax
endm