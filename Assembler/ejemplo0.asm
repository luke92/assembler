
org 100h
    jmp INICIO
    
    MENSAJE db "ME CAGO EN ASSEMBLERRRRRRRRRRRRRR.", 13, 10, "$"
    LARGO equ 14
    
INICIO:
    mov dx, offset MENSAJE
    mov ah, 9
    int 21h
    
    mov ah, 4ch
    int 21h




