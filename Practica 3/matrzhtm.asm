
imprimirhtml macro
PUSH ax
PUSH dx
Escribirarchivo SIZEOF cadenahtml, cadenahtml,handleFichero
Escribirarchivo SIZEOF titulohtml, titulohtml, handleFichero
lea bx,tiempo
call obtenertiempo
Escribirarchivo SIZEOF tiempo, tiempo, handleFichero
Escribirarchivo SIZEOF ctitulohtml, ctitulohtml, handleFichero
;creacion de los nodos de la tabla
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl1,0
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl2,1
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl3,0
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl4,1
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl5,0
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl6,1
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl7,0
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero
Escribirarchivo SIZEOF cadtr, cadtr,handleFichero
reperit fl8,1
Escribirarchivo SIZEOF ccadtr, ccadtr,handleFichero

Escribirarchivo SIZEOF ccadbody,ccadbody,handleFichero
POP dx
POP ax

endm

reperit macro arr, tipo
LOCAL rept,cambio1,cambio2,salto
PUSH ax
PUSH bx
mov ax,0
mov bx,tipo
rept:
    cadhtml arr,bx
    cadhtml2 arr, ax
    cadhtml3 arr,ax
    cmp bx,0
        je cambio1
    cmp bx,1 
        je cambio2
cambio1:
    mov bx,1
    jmp salto
cambio2:
    mov bx,0
    jmp salto
salto:
    inc ax
    cmp ax, 8
        jne rept
POP bx
POP ax
endm

cadhtml macro array, tipo
LOCAL Incio,fondo1,fondo2,Etiqueta_salida
PUSH ax
PUSH bx

;recorremos cada fila para armar la matriz
Incio:
    cmp tipo,0
        je fondo1
    cmp tipo,1
        je fondo2
fondo1:
    Escribirarchivo SIZEOF cadtd1, cadtd1, handleFichero
    jmp Etiqueta_salida
fondo2:
    Escribirarchivo SIZEOF cadtd2, cadtd2, handleFichero
    jmp Etiqueta_salida
Etiqueta_salida:

POP bx
POP ax
endm

cadhtml2 macro array, valor
LOCAL ImprimirMatriz,BloqueBlanca,Etiqueta_salida
PUSH ax
PUSH bx
PUSH dx
;recorremos cada fila para armar la matriz
ImprimirMatriz:
    mov si, valor
    mov dh, array[si]
    cmp dh, 1
        je BloqueBlanca
    jmp Etiqueta_salida
BloqueBlanca:
    Escribirarchivo SIZEOF fichablanca, fichablanca, handleFichero
    jmp Etiqueta_salida

Etiqueta_salida:

POP dx
POP bx
POP ax
endm

cadhtml3 macro array, valor
LOCAL ImprimirMatriz,BloqueVacio,Etiqueta_salida,valid
PUSH ax
PUSH bx
PUSH dx
;recorremos cada fila para armar la matriz
ImprimirMatriz:
    mov si, valor
    mov dh, array[si]
    cmp dh, 0
        je Etiqueta_salida
    jmp valid
valid:
    mov si, valor
    mov dh, array[si]
    cmp dh, 1
        je Etiqueta_salida
    jmp BloqueVacio
BloqueVacio:
    Escribirarchivo SIZEOF fichanegra, fichanegra, handleFichero
    jmp Etiqueta_salida
Etiqueta_salida:
     Escribirarchivo SIZEOF ccadtd, ccadtd, handleFichero

POP dx
POP bx
POP ax
endm
