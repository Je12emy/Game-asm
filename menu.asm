 include marco.asm    
 include carriles.asm 
 include carretera.asm
 
.MODEL SMALL
.STACK 100H
.DATA
    ;Prueba de GitHub
    iniciar db "[1] INICIAR EL JUEGO.$"
    marcador db "[2] VER MARCADORES.$"
    salir db   "[3] SALIR.$"
    input db "INGRESE UN NUMERO:|$"
    error db "NO HA INGRESADO UNA DE LAS OPCIONES!$" 
    precione db "[PRECIONE UNA TECLA]$"
    puntero db ":"
    x dw "$"
    y dw "$" 
    
    xx dw ?
    yy dw ?

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
       
    mov grosor,03h
    MOV AH,00
    MOV AL,12H
    INT 10H 
    marco_juego x,y,length, grosor
                      
                            ;Escribir los mensajes del menu
      
      
opciones:    
    mov dx,0D1Bh            ;DL: X, DH: Y
    mov ah,02h


    int 10h
    
    lea dx,inicio
    mov ah,09h 
    int 21h
        
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
    
    

    MOV AH,00
    MOV AL,12H
    INT 10H 
    
    mov grosor,03h
    marco_juego x,y,length, grosor
    
    
    PALETA 02H
     
    mov xx, 10
    mov yy, 10
    mov x, 155
    mov y,10  
     
        
    BORDER
       
    FONDO 
   
    mov xx,1h
    mov yy,1h   

    mov x,13Eh
    mov y,10h

                 
    LINEASALTEADA x,y,xx,yy
   
   
        
        
    call readkey()
    
    
halt:
    mov ah,4ch
    int 21h
    
comparar proc
mayor1:    
    cmp al,31H
    je juego
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