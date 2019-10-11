
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

jmp code

valores db 50,48,53,49,52,50,55,51
sum dw ?
total equ 8h

code: lea bx,valores
    mov sum,0
    mov cx,0

sigue: mov al, [bx]
       add sum,ax
       inc cx
       inc bx
       cmp cx,total
       jne sigue
       mov ax, [sum]
       call calculo
       mov sum,ax
       call mostrar
       
proc calculo
    div cx
calculo endp

proc mostrar
    mov dl,al
    mov ah,02h
    int 21h
mostrar endp


ret




