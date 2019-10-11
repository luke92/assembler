
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

    jmp INICIO

DATOS db "Esto es un texto de prueba.$"
POSICION db ?

INICIO:
    mov bx, offset DATOS
    mov ah, 'x'
    call MIFUNCION
    mov POSICION, al
ret                 
MIFUNCION proc near
    push cx
    mov cl, 0
CICLO:
    cmp [bx], '$'
    je ETIQUETA1
    cmp [bx], ah
    je ETIQUETA1
    inc bx
    inc cl
    jmp CICLO
ETIQUETA1:
    mov al, cl
    pop cx
    ret
MIFUNCION endp




