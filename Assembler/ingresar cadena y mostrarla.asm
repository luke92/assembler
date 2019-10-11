
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
  
  ;Ingresar cadena de 10 caracteres y mostrarla
  
	org 100h
		mov dx, offset buffer
		mov ah, 0ah
		int 21h
		jmp print
		buffer db 11,?, 11 dup(' ')
		print:
		xor bx, bx
		mov bl, buffer[1]
		mov buffer[bx+2], '$'
		mov dx, offset buffer + 2
		mov ah, 9
		int 21h
		ret




