org 100h    
                JMP JUEGO
            
MAX_LARGO equ 10
LARGO db 0
ACIERTOS db 0
ACIERTOSBIEN db 0
ACIERTOSREGU db 0
SWITCH db 0
LETRA db 0                     
DECENA db 0
UNIDAD db 0

SECRETA db MAX_LARGO +1 dup ('$') 
ADIVINO db MAX_LARGO +1 dup ('$')
PALABRA db MAX_LARGO +1 dup ('$')
MSG_BIEN db "Bien: $"
MSG_REGU db "Regular: $"
MSG_PALABRA db "Ingrese una palabra ", 13, 10, "$"
MSG_PERDIO db "Lo siento, la palabra era $" 
MSG_GANO db "Felicidades, ha ganado!$"
MSG_OCULTA db "Ingrese una palabra y presione Enter", 13, 10, "$" 
MSG_ADIVINE db 10, 13, "Adivine la palabra oculta!", 13, 10, "$"        
MSG_LETRA db "Ingrese una letra", 13, 10, "$"         
MSG_JUEGO db "BIENVENIDOS A NUESTRO JUEGO", 13, 10, "$"
MSGVIDAS db "Vidas restantes: $" 

CRLF db 13, 10, "$"
VIDAS db 9
ESTRELLA db " * $"     



             

JUEGO:          
                CALL mostrarMSGJUEGO
                
                CALL mostrarMSGOCULTA
              
                CALL ingresarPalabraOculta
                
                CALL mostrarMSGADIVINE
                
                
                
                
ADIVINAR:       CMP VIDAS, 0  ; Si llega a cero, PERDISTE
                JE  PERDISTE
                
                CALL mostrarMSGVIDAS
                CALL mostrarVidas
                CALL newLine
                
                CALL mostrarMSGPALABRA
                
                CALL IngresarPalabraAdivina
                
                CALL newLine
                
                
                CALL almacenarCaracteresBien
                
                CALL mostrarMSGBIEN
                CALL mostrarCantBien
                
                CALL newLine
                
                CALL almacenarCaracteresRegular
                
                CALL mostrarMSGREGU
                CALL mostrarCantRegu
                
                CALL newLine
                
                CALL mostrarADIVINO
                
                CALL newLine
                
                
                MOV AL, LARGO
                CMP ACIERTOSBIEN, AL
                JE GANASTE
                
                DEC VIDAS
                JMP ADIVINAR
                                
PERDISTE:       CALL mostrarMSGPERDIO
                
                CALL mostrarSECRETA
                
                                                                             
                RET
                
                
GANASTE:        CALL mostrarMSGGANO
                
                                             
                RET
                


ingresarPalabraAdivina PROC NEAR
                
                    MOV BX, 0    
                
    CicloINGPA:      CMP BL, LARGO
                    JE  FinINGRESARPA
                    CALL ingresarCaracterOculto
                    
                
                    MOV PALABRA[BX], AL
                    MOV ADIVINO[BX], '.'
                    INC BX
                    mov dl, AL
                    CALL mostrarCaracter
                    JMP CicloINGPA


    FinINGRESARPA:   
                     RET 

ingresarPalabraAdivina ENDP

                
ingresarPalabraOculta PROC NEAR          
                    
                                
                    MOV BX, 0    
                
    CicloINGp:      CMP BX, MAX_LARGO
                    JE  CHANGE
                    CALL ingresarCaracterOculto
                    
                
                    CMP AL,CRLF
                    JE  CHANGE
                    MOV SECRETA[BX], AL
                    ;MOV ADIVINO[BX], '.'
                    INC BX
                    INC LARGO
                    mov dl, '*'
                    CALL mostrarCaracter
                    JMP CicloINGp

    CHANGE:         MOV BX, 0
                                
    CicloCHAN:      CMP SECRETA[BX], '$'
                    JE  FinINGRESARp
                    ;MOV ADIVINO[BX],'.'
                    INC BX
                    JMP CicloCHAN

    FinINGRESARp:   
                     RET 

ingresarPalabraOculta ENDP 

  
almacenarCaracteresRegular PROC NEAR
    
        MOV ACIERTOSREGU, 0
        mov cx, 0
        mov bx, 0
        
        cicloACR1:   CMP SECRETA[BX], '$'
                     je finACR
                     
                     CALL buscarCoincidencia
                     inc BX
                     jmp cicloACR1
                    
        
        finACR: mov ACIERTOSREGU, cl
                RET
    
almacenarCaracteresRegular ENDP


buscarCoincidencia PROC NEAR
    
    mov SI, 0
    mov al, PALABRA[BX]
    
    cicloBC:    cmp SECRETA[SI], '$'
                je finBC
                cmp ADIVINO[SI], '.'
                jne cicloBC2
                cmp SECRETA[SI], al
                je reemplazar
                
    cicloBC2:   inc SI
                jmp cicloBC
    
    reemplazar:     mov ADIVINO[SI], al
                    inc cx                         
                    jmp cicloBC2
    
    finBC:  ret
                          
buscarCoincidencia ENDP


mostrarCantRegu PROC NEAR
      
    mov al, ACIERTOSREGU
    cmp al, ACIERTOSBIEN
    jge restarMCR
    jmp mostrarMCR
    
restarMCR:
    sub al, ACIERTOSBIEN
    jmp mostrarMCR

mostrarMCR:
    mov dl, al
    add dl, 30h
    CALL mostrarCaracter
    ret

mostrarCantRegu ENDP
                        
                        
mostrarCantBien PROC NEAR
    
    mov dl, ACIERTOSBIEN
    add dl, 30h
    CALL mostrarCaracter
    ret
        
mostrarCantBien ENDP


almacenarCaracteresBien PROC NEAR
    
    MOV ACIERTOSBIEN, 0
    mov cx, 0
    mov bx, 0
                
    cicloACB:   CMP SECRETA[BX], '$'
                je finACB
                
                mov al, PALABRA[BX]
                
                cmp SECRETA[BX], al
                je  almacenarBien
                
 contCicloACB:  inc bx
                jmp cicloACB
                
    almacenarBien:  
                    inc cx
                    ;mov ADIVINO[BX], al
                    jmp contCicloACB
    
    finACB: mov ACIERTOSBIEN, cl 
            ret
                
almacenarCaracteresBien ENDP  
             

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
        
        MOV AH, 0ah
        INT 21H
        ret

ingresarCadena ENDP

    
mostrarCadena PROC NEAR

        MOV AH, 9
        INT 21H
        ret

mostrarCadena ENDP


newLine PROC NEAR
        MOV DX,offset CRLF
        CALL mostrarCadena
        ret
        
newLine ENDP
        
        
mostrarMSGJUEGO PROC NEAR
    
    MOV DX, offset MSG_JUEGO
    CALL mostrarCadena
    RET

mostrarMSGJUEGO ENDP


mostrarMSGOCULTA PROC NEAR

    MOV DX, offset MSG_OCULTA
    CALL mostrarCadena
    RET

mostrarMSGOCULTA ENDP


mostrarMSGADIVINE PROC NEAR

    MOV DX, offset MSG_ADIVINE
    CALL mostrarCadena
    RET

mostrarMSGADIVINE ENDP


mostrarMSGPALABRA PROC NEAR

    LEA DX, MSG_PALABRA
    CALL mostrarCadena
    RET

mostrarMSGPALABRA ENDP


mostrarMSGBIEN PROC NEAR

    MOV DX, offset MSG_BIEN
    CALL mostrarCadena
    RET

mostrarMSGBIEN ENDP


mostrarMSGREGU PROC NEAR

    MOV DX, offset MSG_REGU
    CALL mostrarCadena
    RET

mostrarMSGREGU ENDP


mostrarADIVINO PROC NEAR

    MOV DX, offset ADIVINO
    CALL mostrarCadena
    RET

mostrarADIVINO ENDP


mostrarMSGPERDIO PROC NEAR

    MOV DX, offset MSG_PERDIO
    CALL mostrarCadena
    RET

mostrarMSGPERDIO ENDP


mostrarMSGGANO PROC NEAR

    MOV DX, offset MSG_GANO
    CALL mostrarCadena
    RET

mostrarMSGGANO ENDP


mostrarSECRETA PROC NEAR

    MOV DX, offset SECRETA
    CALL mostrarCadena
    RET

mostrarSECRETA ENDP

mostrarMSGVIDAS PROC NEAR
    
    LEA DX, MSGVIDAS
    CALL mostrarCadena
    RET

mostrarMSGVIDAS ENDP

mostrarVidas PROC NEAR
    
   MOV DL, VIDAS
   ADD DL, 30h
   CALL mostrarCaracter
   RET              

mostrarVidas ENDP
                    
