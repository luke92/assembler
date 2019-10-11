org 100h    
                JMP JUEGO
            
MAX_LARGO equ 10
LARGO db 0
ACIERTOS db 0
SWITCH db 0
LETRA db 0                     

SECRETA db MAX_LARGO +1 dup ('$') 
ADIVINO db MAX_LARGO +1 dup ('$')
MSG_PERDIO db "Lo sento, la palabra era $" 
MSG_GANO db "Felicidades!$"
MSG_OCULTA db "Ingrese una palabra y presione Enter", 13, 10, "$" 
MSG_ADIVINE db "Adivine la palabra oculta!", 13, 10, "$"        
MSG_LETRA db "Ingrese una letra", 13, 10, "$"         
MSG_JUEGO db "BIENVENIDOS A NUESTRO JUEGO", 13, 10, "$" 

CRLF db 13, 10, "$"
VIDAS db 11
ESTRELLA db " * $"     


             

JUEGO:          MOV AH, 9
                MOV DX, offset MSG_JUEGO
                INT 21h
                CALL IngresarPALABRA ;CALL llama a un proceso
                
                MOV AH, 9
                MOV DX, offset MSG_ADIVINE
                INT 21h
                
                
ADIVINAR:       CMP VIDAS, 0  ; Si llega a cero, PERDISTE
                JE  PERDISTE
                
                CALL IngresarLETRA
                
                CMP SWITCH, 0 
                JNE MostrarESTRELLA
                
                MOV AH, 9
                MOV DX, offset ADIVINO
                INT 21h
                
                MOV AH, 9
                MOV DX, offset CRLF
                INT 21h            
                JMP COMPARAR

MostrarESTRELLA:DEC VIDAS  ;DEC disminuye las vidas
                MOV AH, 9
                MOV DX, offset ADIVINO
                INT 21h
                MOV AH, 9
                MOV DX, offset ESTRELLA
                INT 21h
                
                MOV AH, 2
                MOV DL, LETRA
                INT 21h
                
                MOV AH, 9
                MOV DX, offset CRLF
                INT 21h
                            
                JMP COMPARAR
                

                                   
COMPARAR:       MOV SWITCH, 0
                MOV AH, LARGO
                CMP ACIERTOS, AH
                JNE ADIVINAR
                JE  GANASTE
                
                                
PERDISTE:       MOV AH, 9
                MOV DX, offset MSG_PERDIO
                INT 21h
                MOV AH, 9
                MOV DX, offset SECRETA
                INT 21h                                                             
                RET
                
                
GANASTE:        MOV AH, 9
                MOV DX, offset MSG_GANO
                INT 21h                             
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
                MOV AH, 9
                MOV DX, offset MSG_LETRA
                INT 21h
                
                MOV AH, 7
                INT 21h
                CALL REMPLAZAR
                        
                RET                     
IngresarLETRA ENDP      ;Fin del Proceso

                
IngresarPALABRA PROC NEAR  ;Inicio del Proceso          
                    MOV AH, 9
                    MOV DX, offset MSG_OCULTA
                    INT 21h            
                    MOV BX, 0    
                
    CicloINGp:      CMP BX, MAX_LARGO
                    JE  CHANGE
                    MOV AH, 7
                    INT 21h
                
                    CMP AL,CRLF
                    JE  CHANGE
                    MOV SECRETA[BX], AL
                    INC BX
                    INC LARGO
                    JMP CicloINGp

    CHANGE:         MOV BX, 0
                                
    CicloCHAN:      CMP SECRETA[BX], '$'
                    JE  FinINGRESARp
                    MOV ADIVINO[BX],'.'
                    INC BX
                    JMP CicloCHAN

    FinINGRESARp:   RET 
IngresarPALABRA ENDP       ;Fin del Proceso 
