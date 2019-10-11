
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
 
 ;Mostrar una cadena
 
org 100h
		mov dx, offset msg
		mov ah, 9
		int 21h
		ret
		msg db "hello world $"




