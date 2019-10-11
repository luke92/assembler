org 100h    
                JMP JUEGO
            
MAX_LARGO equ 10
LARGO db 0
ACIERTOS db 0
SWITCH db 0
LETRA db 0                     

SECRETA db MAX_LARGO +1 dup ('$') 
ADIVINO db MAX_LARGO +1 dup ('$')
MSG_PERDIO db "Lo siento, la palabra era $" 
MSG_GANO db "Felicidades!$"
MSG_OCULTA db "Ingrese una palabra y presione Enter", 13, 10, "$" 
MSG_ADIVINE db 10, 13, "Adivine la palabra oculta!", 13, 10, "$"        
MSG_LETRA db "Ingrese una letra", 13, 10, "$"         
MSG_JUEGO db "BIENVENIDOS A NUESTRO JUEGO", 13, 10, "$" 

CRLF db 13, 10, "$"
VIDAS db 11
ESTRELLA db " * $"     



             

JUEGO:          
                MOV DX, offset MSG_JUEGO
                CALL mostrarCadena
                
                CALL IngresarPALABRA ;CALL llama a un proceso
                
                MOV DX, offset MSG_ADIVINE
                CALL mostrarCadena
                
                
ADIVINAR:       CMP VIDAS, 0  ; Si llega a cero, PERDISTE
                JE  PERDISTE
                
                CALL IngresarLETRA
                
                CMP SWITCH, 0 
                JNE MostrarESTRELLA             
                
                MOV DX, offset ADIVINO
                CALL mostrarCadena
                
                
                MOV DX, offset CRLF
                CALL mostrarCadena
                    
                JMP COMPARAR

MostrarESTRELLA:DEC VIDAS  ;DEC disminuye las vidas

                MOV DX, offset ADIVINO
                CALL mostrarCadena
                
                MOV DX, offset ESTRELLA
                CALL mostrarCadena
                
                
                MOV DL, LETRA
                CALL mostrarCaracter
                
                
                MOV DX, offset CRLF
                CALL mostrarCadena
                            
                JMP COMPARAR
                

                                   
COMPARAR:       MOV SWITCH, 0
                MOV AH, LARGO
                CMP ACIERTOS, AH
                JNE ADIVINAR
                JE  GANASTE
                
                                
PERDISTE:       
                MOV DX, offset MSG_PERDIO
                CALL mostrarCadena
                
                MOV DX, offset SECRETA
                CALL mostrarCadena
                                                                             
                RET
                
                
GANASTE:        
                MOV DX, offset MSG_GANO
                CALL mostrarCadena
                                             
                RET
                

REMPLAZAR PROC NEAR  ;Inicio del Proceso            
                    MOV AH, ACIERTOS
                    MOV BX, 0    
    CicloREM:       CMP SECRETA[BX], '$' 
                    JE  FinREMPLAZAR
                
                    CMP SECRETA[BX], AL
                    JE  REMP
                             
    ACA:            INC BX
                    JMP CicloREM
                
    FinAUXILIAR:    MOV SWITCH , 1
                    MOV LETRA, AL
                    RET                

    FinREMPLAZAR:   CMP AH, ACIERTOS
                    JE  FinAUXILIAR
                    RET

    REMP:           CMP ADIVINO[BX], AL 
                    JE  ACA
                    MOV ADIVINO[BX], AL
                    INC ACIERTOS
                    JMP CicloREM
REMPLAZAR ENDP       ;Fin del Proceso


IngresarLETRA PROC NEAR ;Inicio del Proceso               
                MOV DX, offset MSG_LETRA
                CALL mostrarCadena
                
                CALL ingresarCaracterOculto
                
                CALL REMPLAZAR
                        
                RET                     
IngresarLETRA ENDP      ;Fin del Proceso

                
IngresarPALABRA PROC NEAR  ;Inicio del Proceso          
                    MOV DX, offset MSG_OCULTA
                    CALL mostrarCadena
                                
                    MOV BX, 0    
                
    CicloINGp:      CMP BX, MAX_LARGO
                    JE  CHANGE
                    CALL ingresarCaracterOculto
                    
                
                    CMP AL,CRLF
                    JE  CHANGE
                    MOV SECRETA[BX], AL
                    INC BX
                    INC LARGO
                    mov dl, '*'
                    CALL mostrarCaracter
                    JMP CicloINGp

    CHANGE:         MOV BX, 0
                                
    CicloCHAN:      CMP SECRETA[BX], '$'
                    JE  FinINGRESARp
                    MOV ADIVINO[BX],'.'
                    INC BX
                    JMP CicloCHAN

    FinINGRESARp:   RET 
IngresarPALABRA ENDP       ;Fin del Proceso 

         
         
         
         
ingresarCaracterOculto PROC NEAR
        MOV AH, 7
        INT 21H
        ret
ingresarCaracterOculto ENDP

mostrarCaracter PROC NEAR
        MOV AH, 2
        INT 21H
        ret
mostrarCaracter ENDP


ingresarCadena PROC NEAR
        MOV AH, 0Ah
        INT 21H
        ret
ingresarCadena ENDP
    
mostrarCadena PROC NEAR
        MOV AH, 9
        INT 21H
        ret
mostrarCadena ENDP