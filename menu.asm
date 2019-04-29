 include marco.asm    
 include carriles.asm 
 include carretera.asm
 include write.asm
 
;Macros especiales para los personajes del juego

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
 
 
 
 
 
 
 
.MODEL SMALL
.STACK 100H
.DATA
    ;Parametros para el menu
    iniciar db "[1] INICIAR EL JUEGO.$"
    marcador db "[2] VER MARCADORES.$"
    salir db   "[3] SALIR.$"
    input db "INGRESE UN NUMERO:|$"
    error db "NO HA INGRESADO UNA DE LAS OPCIONES!$" 
    precione db "[PRECIONE UNA TECLA]$"
    puntero db ":"
    
    ;Parametros genericos
    x dw "$"
    y dw "$" 
    
    xx dw ?
    yy dw ?

    length dw "$"
    color db "$" 
    grosor db "$"
    fondo db "$"
    ENTER   DB      0AH,0DH,'$'
    
   
    ;xx      dw 1
    ;yy      dw 1
        
    XAUX    DW 0
    YAUX    DW 0   
    
    ;Parametros para los carros.
        
    ;X       dw 319
    ;Y       dw 10  
        
    XCAR    DW 0
    YCAR    DW 0 
        
    MEN1    DB 'GAME OVER','$' 
               
    NUMERO      DW 0 
    VELOCIDAD   DW 0FFFH  
    
    ;Parametro de score
    score dw 0000
    decimas db 00
    unidades db 00 
    decimas_1 db 00
    decimas_2 db 00
    unidades_1 db 00
    unidades_2 db 00
    
    unidades_1_decimas db 00
    unidades_1_unidades db 00          
    
     score_over db "$"             ;Arreglo de numeros
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
             db "$"
    
    final_score   db     50,0,50 dup (0aah)  
    
    ;Parametros para write
     ContieneHandle          DW    0        ; ContieneHandle de control del fichero
     EntradaDelFichero       DB    13,10,"INTRODUCE EL NOMBRE DEL FICHERO: $"
     MensajeDeMostramosError DB    13,10," MostramosError.Mira si has escrito bien el fichero ***",13,10,10,"$"
     GuardarEntradaTeclado   DB    80 DUP (0)   ; BufferLeerDisco para leer desde el teclado
     BufferLeerDisco         DB    2000 DUP (0) ;   "     "     "     "  el disco
     texto db 50,0,"prueba"
     newl                    DB    13,10

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
    ;Dibujo del campo de juego
    

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
    
    ;Dibujo de los personajes de juego.
        mov score,00h
        
        
        MOV X,319
        MOV Y,10
        
    
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
        ;********* 
        inc score
                
;        mov ah,00h
;        mov al,score
;        aam
        
        mov ax,score
        ;aam
        
        mov decimas,ah
        mov unidades,al
                
        ;Imprimir decimas
        xor ax,ax
        mov al,decimas
        aam                     ;Convertir decimas a bcd
        
        mov decimas_1, ah
        mov decimas_2, al       
        
        mov ah,02h
        mov dh,05
        mov dl,06
        int 10h
        
        add decimas_1,30h
        mov dl,decimas_1
        mov ah,02h
        int 21h
        
        mov ah,02h
        mov dh,05
        mov dl,07
        int 10h
        
        add decimas_2,30h
        mov dl,decimas_2
        mov ah,02h
        int 21h       
        
        ;Imprimir unidades
        
        xor ax,ax
        mov ah,00h
        mov al,unidades
        aam
        
        mov unidades_1, ah
        mov unidades_2, al       
        
        ;Descomponer a unidades_1 con aam
        xor ax,ax
        mov al,unidades_1
        aam
        
        mov unidades_1_decimas,ah
        mov unidades_1_unidades,al
              
        
        mov ah,02h
        mov dh,05
        mov dl,08
        int 10h
        
        add unidades_1_decimas,30h
        mov dl,unidades_1_decimas
        mov ah,02h
        int 21h 
        
        mov ah,02h
        mov dh,05
        mov dl,09
        int 10h
        
        add unidades_1_unidades,30h
        mov dl,unidades_1_unidades
        mov ah,02h
        int 21h
        
        
        
;******************        
        
        mov ah,02h
        mov dh,05
        mov dl,0Ah
        int 10h
        
        
        add unidades_2,30h
        mov dl,unidades_2
        mov ah,02h
        int 21h     
        
        
;        mov ah,02h
;        mov dh,05
;        mov dl,07
;        int 10h
;        
;        mov dl,unidades
;        mov ah,02h
;        int 21h
               
        
        
        
        
        
        ;*********
        
                                                       
        mov     ax, 3
        int     33h        
        
        cmp     bx, 1  
        je      LEFT
                  
        cmp     bx, 2  
        je      RIGHT
        
        cmp     bx, 3  
        je      Halt        
        
        RETARDO VELOCIDAD
        
        CUADRO  X,Y,08H,20 ;BORRAR
        ADD     Y,10 
        CUADRO  X,Y,04H,20 
        
        CUADRO  XX,YY,08H,20 ;BORRAR
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
        ;CUADRO  X,Y,00H,20 ;BORRAR
        CUADRO  X,Y,08H,20 ;BORRAR
        MOV     Y,10
        SUB     VELOCIDAD,96H        
        jmp     check_mouse_buttons 
               
VOLVERINICIO2:
        
        CUADRO  XX,YY,08H,20 ;BORRAR
        MOV     YY,10
        jmp     check_mouse_buttons 

LEFT:
        
        CUADRO  XCAR,YCAR,08H,20
        MOV     XCAR,219
        MOV     YCAR,220        
        CUADRO  XCAR,YCAR,0FH,20
        JMP     check_mouse_buttons  
        
RIGHT: 
        
        CUADRO  XCAR,YCAR,08H,20
        MOV     XCAR,421
        MOV     YCAR,220        
        CUADRO  XCAR,YCAR,0FH,20
        JMP     check_mouse_buttons  

GAMEOVER:

        ;    decimas db 00
;    unidades db 00 
;    decimas_1 db 00
;    decimas_2 db 00
;    unidades_1 db 00
;    unidades_2 db 00
;    
;    unidades_1_decimas db 00
;    unidades_1_unidades db 00 

        
 ;       cld                     ; Activa DF para conteo ascendente en SI-DI
;	    ;mov si,offset cadena1 + 1
;	    ;lodsb				;extrae el byte con la cantidad de letras leidas desde el KB => AL
;	
;	    mov ah,00h
;	    mov di,offset final_score+ 2  ; DI contiene el inicio de la palabra
;	
;	    add di,00h             ;se suma al inicio de la palabra digitada
;		                   ; se tiene ahora apuntando DI al final de la palabra
;	    mov al,decimas_1
;	    stosb           
;	    
;	    mov al,decimas_2
;	    stosb
;	    
;	    mov al,unidades_1_decimas
;	    stosb 
;
;	    mov al,unidades_1_unidades
;	    stosb
;	    
;	    mov al,unidades_2
;	    stosb
;	    
;	    
;	    mov ah,02h
;	    mov al,13h
;	    int 10h
;	    
	    
        
        
        xor ax,ax
        
        mov ah,decimas_1
        mov al,decimas_2
        mov [score_over], ah
        mov [score_over+1],al
        
        mov ah,unidades_1_decimas
        mov al,unidades_1_unidades
        mov [score_over+2],ah
        mov [score_over+3],al
        
        mov al,unidades_2
        mov [score_over+4], al
        
        escribir ContieneHandle,EntradaDelFichero,MensajeDeMostramosError, GuardarEntradaTeclado, BufferLeerDisco, newl,score_over 

       
        mov ah,02h
        mov dh,07
        mov dl,05
        int 10h
        
        LEA     DX,MEN1
        MOV	    AH,9
        INT     21H
        ;**********
        ;mov ah,00h
;        mov al,score
;        aam
;        
;        mov dl,al
;        mov ah,02h
;        int 21h
        ;**********
            
        call readkey()
    
    
HALT:        

        MOV AH,01H
        INT 21H
        
        MOV AH,00H
        MOV AL,03H
        INT 10H

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