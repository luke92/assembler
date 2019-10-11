
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

        mov bx, 0
        mov dx, bx
LABEL1: cmp bx, N
        je LABEL2
        mov al, DATOS[bx]
        mul D
        add dx, ax
        inc bx
        jmp LABEL1
LABEL2: mov R, dx 
        ret
        
DATOS db 1,5,3,4,12
R   dw ?
D   db 10
N   equ 5




