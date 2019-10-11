
org 100h
    jmp INICIO
    
    MENSAJE db "ME CAGO EN ASSEMBLER.", 13, 10, "$"
    LARGO equ 14
    
INICIO:
    mov cx, LARGO
    mov bx, offset MENSAJE
CICLO:
    sub [bx], 32
    inc bx
    dec cx
    jnz CICLO
    
    mov dx, offset MENSAJE
    mov ah, 9
    int 21h
    
    mov ah, 4ch
    int 21h




