
GRAPH MACRO               ;iniciamos modo grafico
            MOV AH,00H
            MOV AL,12H    ;640x480
            INT 10H
      ENDM

PALETA MACRO color            ;Permite definir la paleta
                MOV AH,0BH
                MOV BH,00H
                MOV BL,color
                INT 10H
        ENDM

PUNTO MACRO x,y,color
                MOV AH,0CH
                MOV AL,color    ;Color blanco
                MOV BH,0        
                MOV CX,x
                MOV DX,y
                INT 10H
ENDM 

LINEASALTEADA MACRO X,Y,XX,YY
     
                LOCAL   AMARILLO,MOVAMARILLO,SEGUNDALINEA,SALIR
                              
AMARILLO:   
                MOV     CX,0020       
MOVAMARILLO:    push    cx
                PUNTO   xx,yy,0Eh
                pop     cx 
                
                MOV     AX,y
                MOV     yy,AX       ;Guardamos posicion anterior
                mov     bx,x        ;X lo movemos a XX
                MOV     xx,bx
                INC     AX
                CMP     AX,460
                JE      SEGUNDALINEA
                MOV     y,AX
                LOOP    MOVAMARILLO

                ADD     Y,20
                
                JMP     AMARILLO              

SEGUNDALINEA:
                MOV     Y,10
                INC     X
                CMP     X,321
                JBE     AMARILLO               
SALIR:                              
                                                            
ENDM

CUADRO MACRO X,Y,COLOR,TAMANO
    
    LOCAL   FILA,COLUMNA,FILA2,COLUMNA2
    XOR     DX,DX        
    MOV     BX,TAMANO
    MOV     NUMERO,BX
    
    MOV     BX,X
    MOV     XAUX,BX
    
    MOV     BX,Y
    MOV     YAUX,BX
    
FILA:
    PUNTO   XAUX,YAUX,COLOR
    INC     XAUX
    DEC     NUMERO
    JNZ     FILA
    
    DEC     XAUX    
    INC     YAUX
    MOV     BX,TAMANO
    MOV     NUMERO,BX
    
COLUMNA:

    PUNTO   XAUX,YAUX,COLOR
    INC     YAUX
    DEC     NUMERO
    JNZ     COLUMNA
    
    DEC     XAUX
    DEC     YAUX
    MOV     BX,TAMANO
    MOV     NUMERO,BX

FILA2:
    
    PUNTO   XAUX,YAUX,COLOR
    DEC     XAUX
    DEC     NUMERO
    JNZ     FILA2
    
    INC     XAUX
    DEC     YAUX
    MOV     BX,TAMANO
    MOV     NUMERO,BX
    
COLUMNA2:    
    
    PUNTO   XAUX,YAUX,COLOR
    DEC     YAUX
    DEC     NUMERO
    JNZ     COLUMNA2
    INC     XAUX
    INC     YAUX

ENDM 

RETARDO MACRO   VELOCIDAD
    
        LOCAL   RETARDO1,RETARDO2    
        PUSH    CX
        MOV 	CX,  VELOCIDAD	
RETARDO1:
        MOV 	BX,  0FH
RETARDO2:
        DEC 	BX
        JNZ 	RETARDO2
        LOOP 	RETARDO1
        POP     CX        
ENDM

.model small
.stack
.data
        xx      dw 1
        yy      dw 1
        
        XAUX    DW 0
        YAUX    DW 0
        
        X       dw 319
        Y       dw 10  
        
        XCAR    DW 0
        YCAR    DW 0 
        
        MEN1    DB 'GAME OVER','$' 
               
        NUMERO      DW 0 
        VELOCIDAD   DW 0FFFH
.code
 
        mov     ax,@data
        mov     ds,ax
 
        GRAPH           ;Seteamos modo gr�fico 640*480
        
        LINEASALTEADA X,Y,XX,YY
                
        MOV     XCAR,219
        MOV     YCAR,220
        
        CUADRO  XCAR,YCAR,0FH,20        

        MOV     X,219
        MOV     Y,10
        
        CUADRO  X,Y,04H,20
        
        MOV     XX,421
        MOV     YY,150
        
        CUADRO  XX,YY,04H,20  
        
        ; reset mouse and get its status:
        mov     ax, 0
        int     33h
        
        ; display mouse cursor:
        mov     ax, 1
        int     33h
        
check_mouse_buttons:
        
        MOV     DX,Y
        ADD     DX,20
        CMP     YCAR,DX
        JE      VALIDARXL 
        
        MOV     DX,YY
        ADD     DX,20
        CMP     YCAR,DX
        JE      VALIDARXXL       

SEGUIR:                                                
        mov     ax, 3
        int     33h        
        
        cmp     bx, 1  
        je      LEFT
                  
        cmp     bx, 2  
        je      RIGHT
        
        cmp     bx, 3  
        je      SALIR         
        
        RETARDO VELOCIDAD
        
        CUADRO  X,Y,00H,20 ;BORRAR
        ADD     Y,10 
        CUADRO  X,Y,04H,20 
        
        CUADRO  XX,YY,00H,20 ;BORRAR
        ADD     YY,10
        CUADRO  XX,YY,04H,20        
        
        CMP     Y,460
        JE      VOLVERINICIO 
        
        CMP     YY,460
        JE      VOLVERINICIO2 
                                                
        jmp check_mouse_buttons

VALIDARXL:

        MOV     DX,X
        CMP     XCAR,DX
        JE      GAMEOVER    
        jmp     SEGUIR 
        
VALIDARXXL:

        MOV     DX,XX
        CMP     XCAR,DX
        JE      GAMEOVER    
        jmp     SEGUIR        

VOLVERINICIO:
        
        CUADRO  X,Y,00H,20 ;BORRAR
        MOV     Y,10
        SUB     VELOCIDAD,96H        
        jmp     check_mouse_buttons 
               
VOLVERINICIO2:
        
        CUADRO  XX,YY,00H,20 ;BORRAR
        MOV     YY,10
        jmp     check_mouse_buttons 

LEFT:
        
        CUADRO  XCAR,YCAR,00H,20
        MOV     XCAR,219
        MOV     YCAR,220        
        CUADRO  XCAR,YCAR,0FH,20
        JMP     check_mouse_buttons  
        
RIGHT: 
        
        CUADRO  XCAR,YCAR,00H,20
        MOV     XCAR,421
        MOV     YCAR,220        
        CUADRO  XCAR,YCAR,0FH,20
        JMP     check_mouse_buttons  

GAMEOVER:

        LEA     DX,MEN1
        MOV	    AH,9
        INT     21H
                
SALIR:        

        MOV AH,01H
        INT 21H
        
        MOV AH,00H
        MOV AL,03H
        INT 10H

        mov ah,4ch
        int 21h 
        
end
