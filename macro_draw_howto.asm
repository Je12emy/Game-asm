include macro_draw.txt

.MODEL SMALL
.STACK 100H
.DATA
     x dw "$"
    y dw "$"
    length dw "$"
    color db "$"


.CODE
    mov ax,@data
    mov ds,ax
    
    ;macro para preparar el proyecto grafico
    setup()
    ;Preparar parametros para linea horizontal
    
    mov x,01h
    mov y,02h
    mov length,0013eh
    mov color,015h
    
    ;Llama a la macro para dibujar una linea horizontal
    draw_horizontal_line() x,y,length,15h
    
    ;La macro altera los valores locales, asi que de ser necesario se preparan nuevamente
    mov x,01h
    mov y,02h
    mov length,0013eh
    mov color,015h
    
    ;Llama a la macro para dibujar una linea vertical
    draw_vertical_line() x,y,length,15h
    
    
    mov ah,4ch
    int 21h

    