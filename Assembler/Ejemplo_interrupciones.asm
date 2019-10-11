name 'ejemplo mul'

org 100h

jmp start

;Declaracion de datos
nuevaLinea db 10,13,'$'
buffer db 11,?, 10 dup(' ')

start:
		mov dx, offset buffer
		mov ah, 0ah
		int 21h
			
print:
		mov dx, offset nuevaLinea
		mov ah, 9
		int 21h
		xor bx, bx
		mov bl, buffer[1]
		mov buffer[bx+2], '$'
		mov dx, offset buffer + 2
		mov ah, 9
		int 21h
		ret
