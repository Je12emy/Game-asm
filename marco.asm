;*********************************************    
;*   Macro para dubujar el marco de juego    *    
;*********************************************     
     
marco_juego macro  x,y,length,grosor
    
    LOCAL dibujar_top_line,dibujar_bot_line,dibujar_right_line,dibujar_left_line
        
                                                ;Parametros basicos para dibujo
    mov x,01h
    mov y,01h
    mov length,0027Fh
    mov grosor,03h
            
    dibujar_top_line:
        mov x,00h
        mov  length,0027Fh
        draw_horizontal_top_line() x,y,length 
        ;fin_dibujo_top_line:
        inc y                      
        dec grosor
        jnz dibujar_top_line
        
        mov grosor,03h
        mov x,00h
        mov y,01DFH 
        
    dibujar_bot_line:
        mov  x,00h
        mov  length,0027Fh
        draw_horizontal_bot_line() x,y,length
        ;fin_dibujo_bot_line:
        dec y                      
        dec grosor
        jnz dibujar_bot_line
        
        mov grosor,03h 
              
    dibujar_right_line:
        mov y,01E0H 
        mov length,1E0H
        draw_vertical_right_line() x,y,length 
        ;fin_dibujo_right_line:
        dec x                                   ;Izquierda
        dec grosor
        jnz dibujar_right_line
    
        mov grosor,03h
        mov x,00h    
    dibujar_left_line:
        mov y,01E0H 
        mov length,1E0H
        draw_vertical_left_line() x,y,length
        
        ;fin_dibujo_left_line:
        inc x                                   ;Derecha
        dec grosor
        jnz dibujar_left_line
    
endm  

    draw_horizontal_top_line() macro x,y, length 
    
    LOCAL loop_dibujo_top
    loop_dibujo_top:
    
    mov cx, x                           ; column
    mov dx, y                           ; row
    mov al, 00Fh                        ; white
    mov ah, 0ch                         ; put pixel
    int 10h
    
    inc x
    dec length   
    jnz loop_dibujo_top  
    
    endm
    
 


draw_horizontal_bot_line() macro x,y, length 
    
    LOCAL loop_dibujo_bot
    loop_dibujo_bot:
    
    mov cx, x                           ; column
    mov dx, y                           ; row
    mov al, 00Fh                        ; white
    mov ah, 0ch                         ; put pixel
    int 10h
    
    inc x
    dec length   
    jnz loop_dibujo_bot
endm


draw_vertical_right_line() macro x,y, length
    
    LOCAL loop_dibujo_right
    loop_dibujo_right:
    
    mov cx, x                           ; column
    mov dx, y                           ; row
    mov al, 00Fh                        ; white
    mov ah, 0ch                         ; put pixel
    int 10h
    
    dec y                               ;Arriba
    dec length
    jnz loop_dibujo_right
endm
    

draw_vertical_left_line() macro x,y, length 
    
    LOCAL loop_dibujo_left
    loop_dibujo_left:
    
    mov cx, x                           ; column
    mov dx, y                           ; row
    mov al, 00Fh                        ; white
    mov ah, 0ch                         ; put pixel
    int 10h
    
    dec y                               ;Arriba
    dec length
    jnz loop_dibujo_left
endm
 
 
 
 

drawpixel() macro x,y
    mov cx, x                           ; column
    mov dx, y                           ; row
    mov al, 00Fh                        ; white
    mov ah, 0ch                         ; put pixel
    int 10h
    ret
endm
    
;    
;    
;.MODEL SMALL
;.STACK 100H
;.DATA
;    grosor db "$"
;    x dw "$"
;    y dw "$"
;    length dw "$"
;.CODE
;    mov ax,@data
;    mov ds,ax
;
;                        
;    mov grosor,03h
;    marco_juego x,y,length, grosor
;    
;    mov ah,4ch
;    int 21h    