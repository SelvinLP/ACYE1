;-- IMPRIMIR MATRIZ
generarmatriz macro 
imprimir linea
imprimir num8
cadenamatriz fl1
imprimir linea
imprimir num7
cadenamatriz fl2
imprimir linea
imprimir num6
cadenamatriz fl3
imprimir linea
imprimir num5
cadenamatriz fl4
imprimir linea
imprimir num4
cadenamatriz fl5
imprimir linea
imprimir num3
cadenamatriz fl6
imprimir linea
imprimir num2
cadenamatriz fl7
imprimir linea
imprimir num1
cadenamatriz fl8
imprimir linea
imprimir letras
endm


cadenamatriz macro array
LOCAL ImprimirMatriz,BloqueVacio,BloqueBlanca,BloqueNegra,Etiqueta_salida
PUSH ax
PUSH dx
mov ax,0
;recorremos cada fila para armar la matriz
ImprimirMatriz:
    mov si, ax
    mov dh, array[si]
    cmp dh, 0
    	je BloqueVacio
    cmp dh, 1
    	je BloqueBlanca
    cmp dh, 2
    	je BloqueNegra
    jmp Etiqueta_salida

BloqueVacio:
    imprimir fichav
    jmp Etiqueta_salida

BloqueBlanca:
    imprimir fichab
    jmp Etiqueta_salida

BloqueNegra:
	imprimir fichan
    jmp Etiqueta_salida

Etiqueta_salida:
	inc ax
    cmp ax, 8
    	jne ImprimirMatriz

POP dx
POP ax
endm


;Juego
juegomatriz macro 

PUSH ax
PUSH dx
xor dh,dh
xor ah,ah
Posiciones:
	mov dh, coordenada[1]
	sub dh,48
	cmp dh,8
		je ValidLista1
	cmp dh,7
		je ValidLista2
	cmp dh,6
		je ValidLista3
	cmp dh,5
		je ValidLista4
	cmp dh,4
		je ValidLista5
	cmp dh,3
		je ValidLista6
	cmp dh,2
		je ValidLista7
	cmp dh,1
		je ValidLista8
	jmp PosSalida
	
ValidLista1:
	;Posicion Origen
	;Posicion destino
	mov al,coordenada[3]
	sub al,97
	mov si,ax
	mov dl,fl1[si]
	cmp dl,0
		je Insertar

	jmp Posiciones2
ValidLista2:
	jmp Posiciones2
ValidLista3:
	jmp Posiciones2
ValidLista4:
	jmp Posiciones2
ValidLista5:
	jmp Posiciones2
ValidLista6:
	jmp Posiciones2
ValidLista7:
	jmp Posiciones2
ValidLista8:
	jmp Posiciones2

Insertar:
	mov al,coordenada[3]
	sub al,97
	mov si,ax
	mov fl1[si],1
	mov al,coordenada[0]
	sub al,97
	mov si,ax
	mov fl1[si],0
	jmp PosSalida

Posiciones2:
	jmp PosSalida
PosSalida:

POP dx
POP ax

endm

