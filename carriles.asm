;Aplicacion que utiliza el modo grafico. 
;Dibuja un punto en el centro de la pantalla y permite 
;moverlo mediante las teclas 8, 4, 6 y 2.
;Y obviamente organizado mediante macros.


;GRAPH MACRO               ;iniciamos modo grafico
;            MOV AH,00H
;            MOV AL,12H    ;640x480
;            INT 10H
;      ENDM
;
;PALETA MACRO color            ;Permite definir la paleta
;                MOV AH,0BH
;                MOV BH,00H
;                MOV BL,color
;                INT 10H
;        ENDM
;

PUNTO MACRO x,y,color
                MOV AH,0CH
                MOV AL,color    ;Color blanco
                MOV BH,0        
                MOV CX,x
                MOV DX,y
                INT 10H
ENDM 

LINEASALTEADA MACRO X,Y,XX,YY
     
                LOCAL   AMARILLO,MOVAMARILLO,NEGRO,MOVNEGRO,SEGUNDALINEA,SALIR
                              
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
                
NEGRO:   
                MOV     CX,0020       
MOVNEGRO:       
                push    cx
                PUNTO   xx,yy,00h
                pop     cx 
                
                MOV     AX,y
                MOV     yy,AX       ;Guardamos posicion anterior
                mov     bx,x        ;X lo movemos a XX
                MOV     xx,bx
                INC     AX
                CMP     AX,460
                JE      SALIR
                MOV     y,AX
                LOOP    MOVNEGRO
                JMP     AMARILLO              

SEGUNDALINEA:
                MOV     Y,10
                INC     X
                CMP     X,321
                JBE     AMARILLO               
SALIR:                              
                              
                              
ENDM    

;.model small
;.stack
;.data
;        xx dw 1
;        yy dw 1
;        x dw 319
;        y dw 10
;.code
; 
;        mov ax,@data
;        mov ds,ax
; 
;        GRAPH           ;Seteamos modo gráfico 640*480
;        
;        LINEASALTEADA X,Y,XX,YY
;
;        MOV AH,01H
;        INT 21H
;        
;        MOV AH,00H
;        MOV AL,03H
;        INT 10H
;
;        mov ah,4ch
;        int 21h
;end
