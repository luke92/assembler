
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; Recibir una tecla y mostrar un asterisco
 

    mov ah, 7
	int 21h 
	
	mov dl, '*'
	mov ah, 2
	int 21h

ret




