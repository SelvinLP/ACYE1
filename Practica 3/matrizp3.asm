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
LOCAL Posiciones,ValidLista1,ValidLista2,ValidLista3,ValidLista4,ValidLista5,ValidLista6,ValidLista7,ValidLista8
LOCAL PosSalida,Insertar1,Insertar2,Insertar3,Insertar4,Insertar5,Insertar6,Insertar7,Insertar8
PUSH ax
PUSH dx
xor dh,dh
xor ah,ah
Posiciones:
	mov dh, coordenada[4]
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
	;Posicion destino verificacion si se puede insertar
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl1[si]
	cmp dl,0
		je Insertar1

	jmp PosSalida
ValidLista2:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl2[si]
	cmp dl,0
		je Insertar2
	jmp PosSalida
ValidLista3:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl3[si]
	cmp dl,0
		je Insertar3
	jmp PosSalida
ValidLista4:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl4[si]
	cmp dl,0
		je Insertar4
	jmp PosSalida
ValidLista5:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl5[si]
	cmp dl,0
		je Insertar5
	jmp PosSalida
ValidLista6:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl6[si]
	cmp dl,0
		je Insertar6
	jmp PosSalida
ValidLista7:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl7[si]
	cmp dl,0
		je Insertar7
	jmp PosSalida
ValidLista8:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov dl,fl8[si]
	cmp dl,0
		je Insertar8
	jmp PosSalida

Insertar1:
	limpiarposinicial 
	insertarmatriz fl1
	jmp PosSalida
Insertar2:
	limpiarposinicial
	insertarmatriz fl2
	jmp PosSalida
Insertar3:
	limpiarposinicial
	insertarmatriz fl3
	jmp PosSalida
Insertar4:
	limpiarposinicial
	insertarmatriz fl4
	jmp PosSalida
Insertar5:
	limpiarposinicial
	insertarmatriz fl5
	jmp PosSalida
Insertar6:
	limpiarposinicial
	insertarmatriz fl6
	jmp PosSalida
Insertar7:
	limpiarposinicial
	insertarmatriz fl7
	jmp PosSalida
Insertar8:
	limpiarposinicial
	insertarmatriz fl8
	jmp PosSalida

PosSalida:

POP dx
POP ax
endm

insertarmatriz macro arr
LOCAL Inicioinsertarmat
PUSH ax
PUSH dx
Inicioinsertarmat:
	xor dh,dh
	mov dl,coordenada[3]
	sub dl, 97
	mov si,dx
	mov al,estadojugador[0]
	mov arr[si],al

POP dx
POP ax
endm


limpiarposinicial macro 
LOCAL Inicioinsertarmat,Salida, Eliminacion1,Eliminacion2,Eliminacion3,Eliminacion4,Eliminacion5,Eliminacion6,Eliminacion7,Eliminacion8
PUSH ax
PUSH dx
Inicioinsertarmat:
	mov dh, coordenada[1]
	sub dh,48
	cmp dh,8
		je Eliminacion1
	cmp dh,7
		je Eliminacion2
	cmp dh,6
		je Eliminacion3
	cmp dh,5
		je Eliminacion4
	cmp dh,4
		je Eliminacion5
	cmp dh,3
		je Eliminacion6
	cmp dh,2
		je Eliminacion7
	cmp dh,1
		je Eliminacion8

	jmp Salida
Eliminacion1:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl1[si],0
	jmp Salida
Eliminacion2:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl2[si],0
	jmp Salida
Eliminacion3:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl3[si],0
	jmp Salida
Eliminacion4:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl4[si],0
	jmp Salida
Eliminacion5:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl5[si],0
	jmp Salida
Eliminacion6:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl6[si],0
	jmp Salida
Eliminacion7:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl7[si],0
	jmp Salida
Eliminacion8:
	xor dh,dh
	mov dl,coordenada[0]
	sub dl, 97
	mov si,dx
	mov fl8[si],0
	jmp Salida

Salida:
POP dx
POP ax
endm
