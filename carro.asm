.model small
.stack 100h
.data
    x dw "$"
    y dw "$"
    length dw "$"
    color db "$" 
    grosor db "$"
    fondo db "$"
.code
     
    mov ax,@data
    mov ds,ax

   
    MOV AH,00
    MOV AL,12H
    INT 10H
    
    ;call readkey() 
                            ;Parametros basicos para dibujo
;    mov x,01h
;    mov y,01h
;    mov length,000Fh
;    mov color,00Fh
;    mov grosor,03h
;    mov fondo,04h
            
    call setup()
           
                    
dibujar_top_line:
    mov length,0Fh                   ;Dibujo de la linea superior
    mov x,70h
    call draw_horizontal_top_line()
    inc y                      
    dec grosor
    jnz dibujar_top_line
    
    
    mov ah,4ch
    int 21h
                                    ;Preparacion para dubujar la linea inferior
    ;mov grosor,03h
    ;mov x,00h
    ;mov y,01DFH 
    
;dibujar_bot_line:                   ;Dibujo de la linea infierior
;    mov  x,00h
;    mov  length,0027Fh
;    call draw_horizontal_bot_line()
;    dec y                      
;    dec grosor
;    jnz dibujar_bot_line
;    
;    mov grosor,03h 
;          
;dibujar_right_line:                 ;Dibujo de la linea derecha
;    mov y,01E0H 
;    mov length,1E0H
;    call draw_vertical_right_line()
;    dec x                                   
;    dec grosor
;    jnz dibujar_right_line
;
;    mov grosor,03h
;    mov x,00h    
;dibujar_left_line:                  ;Dibujo de la linea izquierda
;    mov y,01E0H 
;    mov length,1E0H
;    call draw_vertical_left_line()
;    inc x                                   
;    dec grosor
;    jnz dibujar_left_line
;            







;**************** METODOS ****************
setup() proc
                            ;Preparacion de la pantalla
    MOV AH,00
    MOV AL,12H
    INT 10H
    
    ;call readkey() 
                            ;Parametros basicos para dibujo
    mov x,70h
    mov y,50h
    mov length,0Fh
    
    mov color,00Fh
    mov grosor,0bh
;    mov fondo,04h    
;    call setColor()
    ret
endp



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
    mov al, color  ; white
    mov ah, 0ch ; put pixel
    int 10h
    ret
endp
         
    
    
