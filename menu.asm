.MODEL SMALL
.STACK 100H
.DATA

    iniciar db "[1] INICIAR EL JUEGO.$"
    marcador db "[2] VER MARCADORES.$"
    salir db   "[3] SALIR.$"
    input db "INGRESE UN NUMERO:|$"
    error db "NO HA INGRESADO UNA DE LAS OPCIONES!$" 
    precione db "[PRECIONE UNA TECLA]$"
    puntero db ":"
    x dw "$"
    y dw "$"
    length dw "$"
    color db "$" 
    grosor db "$"
    fondo db "$"
    ENTER   DB      0AH,0DH,'$'

.CODE

inicio:     
     mov ax,@data
     mov ds,ax
     
programa: 
       
    
    call setup()
           
                    
dibujar_top_line:                   ;Dibujo de la linea superior
    mov x,00h
    mov  length,0027Fh
    call draw_horizontal_top_line()
    inc y                      
    dec grosor
    jnz dibujar_top_line
    
                                    ;Preparacion para dubujar la linea inferior
    mov grosor,03h
    mov x,00h
    mov y,01DFH 
    
dibujar_bot_line:                   ;Dibujo de la linea infierior
    mov  x,00h
    mov  length,0027Fh
    call draw_horizontal_bot_line()
    dec y                      
    dec grosor
    jnz dibujar_bot_line
    
    mov grosor,03h 
          
dibujar_right_line:                 ;Dibujo de la linea derecha
    mov y,01E0H 
    mov length,1E0H
    call draw_vertical_right_line()
    dec x                                   
    dec grosor
    jnz dibujar_right_line

    mov grosor,03h
    mov x,00h    
dibujar_left_line:                  ;Dibujo de la linea izquierda
    mov y,01E0H 
    mov length,1E0H
    call draw_vertical_left_line()
    inc x                                   
    dec grosor
    jnz dibujar_left_line
            
                                    ;Escribir los mensajes del menu
      
      
opciones:    
    mov dx,0D1Bh            ;DL: X, DH: Y
    mov ah,02h
    ;mov bh,00h
    int 10h
    
    lea dx,inicio
    mov ah,09h 
    int 21h
    
            
;    mov dx,0E15h            ;DL: X, DH: Y
;    mov ah,02h
;    mov bh,00h
;    int 10h
                 
    
    mov dx,0F1Bh            ;DL: X, DH: Y
    mov ah,02h
    mov bh,00h
    int 10h
    
    lea dx,marcador
    mov ah,09h
    int 21h
     
    mov dx,111Bh            ;DL: X, DH: Y
    mov ah,02h
    mov bh,00h
    int 10h 
     
    
    lea dx,salir
    mov ah,09h
    int 21h

    mov dx,131Bh            ;DL: X, DH: Y
    mov ah,02h
    mov bh,00h
    int 10h 
    
    lea dx, input
    mov ah,09h
    int 21h
    
    call readkey()
    call comparar
    
    juego:
    
    
    
halt:
    mov ah,4ch
    int 21h
    
comparar proc
mayor1:    
    cmp al,31H
    jge menor3 
    jmp erroneo   


menor3:
    cmp al,33H
    jle juego
    jmp erroneo
      
    ret
endp      
erroneo:
    
    mov dx,151Bh            ;DL: X, DH: Y
    mov ah,02h
    mov bh,00h
    int 10h 
    
    lea dx,error
    mov ah,09h
    int 21h
    
    mov dx,171Bh            ;DL: X, DH: Y
    mov ah,02h
    mov bh,00h
    int 10h 
    
    lea dx,precione
    mov ah,09h
    int 21h
    
    call readkey()
    
    mov ah,00
    mov al,12h
    int 10h
    jmp programa

    
    
    
espacio() proc
    lea dx, enter
    mov ah,09h
    int 21h
    
readkey() proc 
    mov ah,01h
    int 21h
    ret
endp

goto() proc
    mov ah,02h
    mov dl,40h             ;Fila
    mov dh,40h             ;Columna
    int 10h
    ret
endp    
setup() proc
                            ;Preparacion de la pantalla
    MOV AH,00
    MOV AL,12H
    INT 10H
    
    ;call readkey() 
                            ;Parametros basicos para dibujo
    mov x,01h
    mov y,01h
    mov length,0027Fh
    mov color,00Fh
    mov grosor,03h
    mov fondo,04h
    ;call setColor()
    ret
endp
setColor() proc
    MOV AH,0BH
    MOV BH,00H            
    MOV BL,fondo
    INT 10H
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
         