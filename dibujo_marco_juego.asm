;*********************************************    
;*   Macro para dubujar el marco de juego    *    
;*********************************************     
     
marco_juego macro  x,y,length,grosor
     
    MOV AH,00
    MOV AL,12H
    INT 10H
    
    ;call readkey() 
                            ;Parametros basicos para dibujo
    mov x,01h
    mov y,01h
    mov length,0027Fh
;    mov color,00Fh
    mov grosor,03h
;    mov fondo,04h
            
    dibujar_top_line:
        mov x,00h
        mov  length,0027Fh
        call draw_horizontal_top_line()
        inc y                      
        dec grosor
        jnz dibujar_top_line
        
        mov grosor,03h
        mov x,00h
        mov y,01DFH 
        
    dibujar_bot_line:
        mov  x,00h
        mov  length,0027Fh
        call draw_horizontal_bot_line()
        dec y                      
        dec grosor
        jnz dibujar_bot_line
        
        mov grosor,03h 
              
    dibujar_right_line:
        mov y,01E0H 
        mov length,1E0H
        call draw_vertical_right_line()
        dec x                                   ;Izquierda
        dec grosor
        jnz dibujar_right_line
    
        mov grosor,03h
        mov x,00h    
    dibujar_left_line:
        mov y,01E0H 
        mov length,1E0H
        call draw_vertical_left_line()
        inc x                                   ;Derecha
        dec grosor
        jnz dibujar_left_line
endm

.MODEL SMALL
.STACK 100H
.DATA
    grosor db "$"
    x dw "$"
    y dw "$"
    length dw "$"
.CODE
    mov ax,@data
    mov ds,ax

                        
    mov grosor,03h
    marco_juego x,y,length, grosor
    
    mov ah,4ch
    int 21h    



;        
;    ;posicionar el cursor para titulo
;    mov dx,0D1Bh            ;DL: X, DH: Y
;    mov ah,02h
;    mov bh,00h
;    int 10h
;    ;escribir string de titulo
;    
;    mov ah,09h
;    lea dx,inicio 
;    int 21h
;    
;                  
;    mov dx,0E15h            ;DL: X, DH: Y
;    mov ah,02h
;    mov bh,00h
;    int 10h
;                  
;    call espacio()
;    
;    mov dx,0F1Bh            ;DL: X, DH: Y
;    mov ah,02h
;    mov bh,00h
;    int 10h
;    
;    lea dx,marcador
;    mov ah,09h
;    int 21h
;     
;    mov dx,111Bh            ;DL: X, DH: Y
;    mov ah,02h
;    mov bh,00h
;    int 10h 
;     
;    ;call espacio()
;    
;    lea dx,salir
;    mov ah,09h
;    int 21h
;
;    mov dx,131Bh            ;DL: X, DH: Y
;    mov ah,02h
;    mov bh,00h
;    int 10h 
;    
;    lea dx, input
;    mov ah,09h
;    int 21h
;    
;    call readkey()
    
;    espacio() proc
;    lea dx, enter
;    mov ah,09h
;    int 21h
;endm
;    
;readkey() proc 
;    mov ah,01h
;    int 21h
;    ret
;endp
;
;goto() proc
;    mov ah,02h
;    mov dl,40h             ;Fila
;    mov dh,40h             ;Columna
;    int 10h
;    ret
;endp    
;setup() macro
;    MOV AH,00
;    MOV AL,12H
;    INT 10H
;    
;    mov x,01h
;    mov y,01h
;    mov length,0027Fh
;    mov color,00Fh
;    mov grosor,03h
;    mov fondo,04h    
;endm
;setColor() proc
;    MOV AH,0BH
;    MOV BH,00H            
;    MOV BL,fondo
;    INT 10H
;    ret
;endp



draw_horizontal_top_line() proc 
    loop_dibujo_top:
    
    call drawpixel()
    inc x
    dec length   
    jnz loop_dibujo_top
    ret
endp 


draw_horizontal_bot_line() proc 
    loop_dibujo_bot:
    
    call drawpixel()
    inc x
    dec length   
    jnz loop_dibujo_bot
    ret
endp

draw_vertical_right_line() proc
    loop_dibujo_right:
    
    call drawpixel()
    dec y                               ;Arriba
    dec length
    jnz loop_dibujo_right
    ret
endp

draw_vertical_left_line() proc
    loop_dibujo_left:
    
    call drawpixel()
    dec y                               ;Arriba
    dec length
    jnz loop_dibujo_left
    ret
endp

drawpixel() proc
    mov cx, x   ; column
    mov dx, y   ; row
    mov al, 00Fh  ; white
    mov ah, 0ch ; put pixel
    int 10h
    ret
endp
   