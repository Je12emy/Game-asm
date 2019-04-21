GRAPH MACRO          ;iniciamos modo gráfico
                MOV AH,00H
                MOV AL,12H
                INT 10H
ENDM

PALETA MACRO color      ;Permite definir la paleta
                MOV AH,0BH
                MOV BH,00H
                MOV BL,color
                INT 10H
ENDM 

PUNTO2 MACRO x,y,color
                MOV AH,0CH
                MOV AL,color    
                MOV BH,0        
                MOV CX,x
                MOV DX,y
                INT 10H
ENDM 

 FONDO MACRO 
                MOV AX,0600h
                MOV BH,0D8h
                MOV CX,0013h
                MOV DX,2040h
                
           
                INT 10H
 ENDM 
 
BORDER MACRO        ;640*480            
                 mov cx,0315 
   moverR:      push cx
                PUNTO2 xx,yy,08h ;0fh
                PUNTO2 x,y,08h 
                pop cx 
                
                MOV AX,x
                MOV xx,AX       ;Guardamos posicion anterior
                mov bx,y        ;y lo movemos a yy
                MOV yy,bx
                INC AX
                MOV X, AX
                loop moverR
                             
                mov cx,0460 
   moverR2:     push cx
                PUNTO2 xx,yy,08h 
                PUNTO2 x,y,08h 
                 pop cx 
                
                MOV AX,y
                MOV yy,AX       ;Guardamos posicion anterior
                mov bx,x        ;X lo movemos a XX
                MOV xx,bx
                INC AX
                MOV y, AX
                loop moverR2       
           
                mov cx,0315 
   moverR3:     push cx
                PUNTO2 xx,yy,08h 
                PUNTO2 x,y,08h 
                pop cx 
                
                MOV AX,x
                MOV xx,AX       ;Guardamos posicion anterior
                mov bx,y        ;y lo movemos a yy
                MOV yy,bx
                DEC AX
                MOV X, AX
                loop moverR3     
                
                mov cx,0460 
   moverR4:     push cx
                PUNTO2 xx,yy,08h 
                PUNTO2 x,y,08h 
                pop cx 
                
                MOV AX,y
                MOV yy,AX       ;Guardamos posicion anterior
                mov bx,x        ;X lo movemos a XX
                MOV xx,bx
                DEC AX
                MOV Y, AX
                loop moverR4            
ENDM

  
  
;.model small
;.stack
;.data
;        xx dw ?
;        yy dw ?
;        x dw ?
;        y dw ?
;              
;       
;        
;.code
;
;        mov ax,@data
;        mov ds,ax
; 
;        GRAPH           ;Seteamos modo gráfico 640*480
;        PALETA 02H
;         
;        
;;HEX    BIN        COLOR
;
;;0      0000      black
;;1      0001      blue
;;2      0010      green
;;3      0011      cyan
;;4      0100      red
;;5      0101      magenta
;;6      0110      brown
;;7      0111      light gray
;;8      1000      dark gray
;;9      1001      light blue
;;A      1010      light green
;;B      1011      light cyan
;;C      1100      light red
;;D      1101      light magenta
;;E      1110      yellow
;;F      1111      white   
;      
;
;        mov xx, 10
;        mov yy, 10
;        mov x, 155
;        mov y,10 
;        
;        BORDER   
;        FONDO 
;        PUSH AX
;        PUSH BX
;
; 
;        MOV AH,07H      ;READKEY
;        INT 21H  
;
;        SALIR:
;
;        MOV AH,00H
;        MOV AL,03H
;        INT 10H
;
;       mov ah,4ch
;       int 21h
;end
