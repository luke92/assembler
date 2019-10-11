org 100h

    mov AH, VAR1
    add AH, VAR2 
    
    mov VALOR1, AH
              
    mov CX, 0
    mov AX, 0
CICLO:              
    add AX, CX
    inc CX
    cmp CX, COTA
    jne CICLO
    
    mov SUMA, AX
ret
           
VAR1   db 64
VAR2   db 0Fh     
VALOR1 db ?
SUMA   dw ?     

COTA equ 10


