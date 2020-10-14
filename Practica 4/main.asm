;-- INCLUDE --
include mcontrol.asm
include marchivo.asm
include mjson.asm
include mconsol.asm
;--CODIGO --
.model small 
.stack 100h 
.data 
encabezado db 0ah,0dh,'UNIVERSIDAD SAN CARLOS DE GUATEMALA', 0ah,0dh, 'FACULDAD DE INGENIERIA', 0ah,0dh,'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1 ',
				0ah,0dh,'NOMBRE: SELVIN LISANDRO ARAGON PEREZ ',0ah,0dh,'CARNET: 201701133 ', 0ah,0dh,'SECCION: A ','$'
encabezadomenu db 0ah,0dh,' ' ,0ah,0dh,'1) Cargar ',0ah,0dh,'2) Consola',0ah,0dh,'3) Salir','$'
ingreruta db 0ah,0dh,'Ingrese ruta: ','$'
ingrecomand db 0ah,0dh,'Ingrese Comando: ','$'
cadresultado db 0ah,0dh,'Resultado: ','$'
rutaarchivo db 100 dup('$'),'$'
rutaexport db 100 dup('$'),'$'
arrayescritura db 5000 dup('$')
handleFichero dw ?  
handleFichero2 dw ?  
cadcomando db 50 dup('$'),'$'
Objpadre db 30 dup('$')
Operadores db 100 dup('$')
ids db 100 dup ('$')
valoresu db 100 dup ('$')
Opera1 db 10 dup('$')
Opera2 db 10 dup('$')
cont db 2 dup(0)
contval db 2 dup(0)
tiempo db '00:00:00'

arrtem db 1 dup(0)
arrtemid db 100 dup ('$')
;Reporte
rep1 db '{',0ah,9h,'"Reporte":',0ah,9h,'{',0ah,9h,9h,'"alumno":',
		0ah,9h,9h,'{',
		0ah,9h,9h,9h,'"Nombre":','"Selvin Lisandro Aragon Perez"',
		0ah,9h,9h,9h,'"Carnet":','"201701133"',
		0ah,9h,9h,9h,'"Seccion":','"A"',
		0ah,9h,9h,9h,'"Curso":','"Arquitectura de Computadores y Ensambladores 1"',
		0ah,9h,9h,'},'
rep2 db 0ah,9h,9h,'"Fecha":',
	0ah,9h,9h,'{',
	0ah,9h,9h,9h,'"Dia":','13',
	0ah,9h,9h,9h,'"Mes":','10',
	0ah,9h,9h,9h,'"Año":','2020',
	0ah,9h,9h,'},'
rep3 db 0ah,9h,9h,'"Hora":',
	0ah,9h,9h,'{',
	0ah,9h,9h,9h,'"Hora":','00',
	0ah,9h,9h,9h,'"Minutos":','00',
	0ah,9h,9h,9h,'"Segundos":','00',
	0ah,9h,9h,'},'
repres db 0ah,9h,9h,'"Resultados":',
	0ah,9h,9h,'{',
	0ah,9h,9h,9h,'"Media":'
remediana db 0ah,9h,9h,9h,'"Mediana":'
remoda db 0ah,9h,9h,9h,'"Moda":'
remenor db 0ah,9h,9h,9h,'"Menor":'
remayor db 0ah,9h,9h,9h,'"Mayor":'

llavedpe db 0ah,9h,9h,'},'
rcomillatb db 0ah,9h,9h,'"'
rcomillatb2 db 0ah,9h,9h,9h,9h,'"'
rcomilla db '":'
llaveI db 0ah,9h,9h,9h,7bh
llaveD db 0ah,9h,9h,9h,'}'
rep5 db 0ah,9h,9h,'['
rep6 db 0ah,9h,9h,']',0ah,9h,'}',0ah,'}'
.code 

main proc
	MenuPrincipal:
		imprimir encabezado 
		imprimir encabezadomenu
		obtenerchar
		cmp al,49
			je Cargar
		cmp al,50
			je Consola
		cmp al,51
			je Salir
		jmp MenuPrincipal
	Cargar:
		imprimir ingreruta
		obtenerruta rutaarchivo
		Abrirarchivo rutaArchivo,handleFichero
		Leerarchivo SIZEOF arrayescritura,arrayescritura,handleFichero
		Cerrararchivo handleFichero
		Leerjson
		jmp MenuPrincipal
	Consola:
		comandcon
		jmp MenuPrincipal
	Salir: 
		MOV ah,4ch 
		int 21h

main endp

obtenertiempo proc
    push ax
    push cx
    ObtenerHora
    mov al, ch
    call Conversion
    mov [bx+25], ax
    mov al, cl
    call Conversion
    mov [bx+41], ax
    mov al, dh
    call Conversion
    mov [bx+58], ax
    pop cx
    pop ax
    ret
obtenertiempo endp

Conversion proc
    push dx
    mov ah, 0
    mov dl, 10
    div dl
    or ax, 3030h
    pop dx
    ret
Conversion endp

end