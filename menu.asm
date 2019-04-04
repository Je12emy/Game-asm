include macro_draw.txt
.MODEL SMALL
.STACK 100H
.DATA
    titulo db "PRUEBA$"
    x dw "$"
    y dw "$"
    length dw "$"
    color db "$"




.CODE
inicio:     
     mov ax,@data
     mov ds,ax
programa:        
    ;setup()
     
     mov ax,0600h
     mov bh,04Fh    ;nibble alto: color del fondo  / nibble bajo: color del texto
     mov cx,010Fh
     mov dx,0940h
     int 10h
       
;    mov ax,0600h
;    mov bh,04Fh    ;nibble alto: color del fondo  / nibble bajo: color del texto
;    mov cx,010Fh
;    mov dx,0940h
;    int 10h
    
    
    mov x,01h
    mov y,02h
    mov length,0013eh
    mov color,015h
    
    ;draw_horizontal_line() x,y,length,color 
    
    ;posicionar el cursor para titulo
    mov dx,0814h
    mov ah,02h
    mov bh,00h
    int 10h
    ;escribir string de titulo
    mov ah,09h
    mov cx,01h
    mov dx,offset titulo; dir. base string CALCULADORA
    int 21h
    

halt:
    mov ah,4ch
    int 21h         