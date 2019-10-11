
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

; dada una secuencia de caracteres
; terminada con '$' obtener en ax
; la cantidad de caracteres
; y en cx la cant de decimales
; sin contar el '$'

org 100h

jmp Inicio
secuencia db 'l','a','c','7','$' 

Inicio:
    mov ax,0
    mov cx,0
    mov bx,0
    jmp Ciclo

Ciclo:
    cmp secuencia[bx], '$'
    je Fin
    cmp secuencia[bx],'0', 30h
    jl Sumar
    cmp secuencia[bx], 39h
    jg Sumar
    add cx,1

Sumar:
    add ax, 1
    inc bx
    jmp Ciclo

Fin:
    mov dx, ax
    add dx, 30h
    mov ah,02h
    int 21h
    
    mov dx, cx
    add dx, 30h
    mov ah,02h
    int 21h

ret




