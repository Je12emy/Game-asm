;MACROS NUEVAS

DISPLAY MACRO
        LOCAL COLOR2,AZUL,VERDE,CIAN,ROJO,MAGENTA,MARRON,CELESTE,AMARILLO,BLANCO,SEGUIR,CHECK_MOUSE_BOTTONS,VOLVERINICIO,TERMINAR
        
COLOR2:      	
      	GRAPH

        MOV     Xmsj,10
        MOV     Ymsj,03
        CURSOR
        LEA     DX,MENAZUL
    	MENSAJE

        MOV     Xmsj,10
        MOV     Ymsj,04
        CURSOR
        LEA     DX,MENVERDE
    	MENSAJE
        
        MOV     Xmsj,10
        MOV     Ymsj,05
        CURSOR
        LEA     DX,MENCIAN
    	MENSAJE        
        
        MOV     Xmsj,10
        MOV     Ymsj,06
        CURSOR
        LEA     DX,MENROJO
    	MENSAJE        
                       
        MOV     Xmsj,10
        MOV     Ymsj,07
        CURSOR
        LEA     DX,MENMAGENTA
    	MENSAJE
       
        MOV     Xmsj,10
        MOV     Ymsj,08
        CURSOR
        LEA     DX,MENMARRON
    	MENSAJE
    	
    	MOV     Xmsj,10
        MOV     Ymsj,09
        CURSOR
        LEA     DX,MENCELESTE
    	MENSAJE
    	
    	MOV     Xmsj,10
        MOV     Ymsj,10
        CURSOR
        LEA     DX,MENAMARILLO
    	MENSAJE
    	
    	MOV     Xmsj,10
        MOV     Ymsj,11
        CURSOR
        LEA     DX,MENBLANCO
    	MENSAJE
    	
    	MOV     Xmsj,10
        MOV     Ymsj,12
        CURSOR
        LEA     DX,MENCOLOR
    	MENSAJE    	
        
        TECLA
        
        CMP     AL,31h
        JE      AZUL       
        CMP     AL,32h
        JE      VERDE        
        CMP     AL,33h
        JE      CIAN        
        CMP     AL,34h
        JE      ROJO        
        CMP     AL,35h
        JE      MAGENTA                    
        CMP     AL,36h
        JE      MARRON        
        CMP     AL,37h
        JE      CELESTE        
        CMP     AL,38h
        JE      AMARILLO        
        CMP     AL,39h
        JE      BLANCO        
        JMP     COLOR2

AZUL:
        MOV     COLOR,01H
        JMP     SEGUIR
VERDE:
        MOV     COLOR,02H
        JMP     SEGUIR
CIAN:
        MOV     COLOR,03H
        JMP     SEGUIR
ROJO:
        MOV     COLOR,04H
        JMP     SEGUIR
MAGENTA:
        MOV     COLOR,05H
        JMP     SEGUIR
MARRON:
        MOV     COLOR,06H
        JMP     SEGUIR
CELESTE:
        MOV     COLOR,09H
        JMP     SEGUIR
AMARILLO:
        MOV     COLOR,0EH
        JMP     SEGUIR
BLANCO:
        MOV     COLOR,0FH

SEGUIR:
    
    GRAPH
    
	MOV DX, OFFSET MS
	MOV AH, 09H
	INT 21H

	
	MOV DX,OFFSET CADENA1
	MOV AH,0AH
    INT 21H

    GRAPH  
    
    mov     ax,0600h
    mov     bh,COLOR         ;nibble alto: color del fondo  / nibble bajo: color del texto
    mov     cx,0200h        ;Y,X ESQUINA SUPERIOR IZQUIERDA
    mov     dx,0450h        ;Y,X ESQUINA INFERIOR DERECHA
    int     10h      
    
    MOV     X,00
    MOV     Y,03
        
    mov     ah,02h 
    MOV     DH,Y   
    MOV     DL,X         
    mov     bh,00h
    int     10h 
    
    IMPRIMIRCADENA CADENA1 
    
    mov     ax, 0
    int     33h
    
    ; display mouse cursor:
    mov     ax, 1
    int     33h

    MOV     VELOCIDAD,01FFFH
    
CHECK_MOUSE_BOTTONS:                        
    
    RETARDO VELOCIDAD
                        
    mov     ax, 3
    int     33h                                
    cmp     bx, 1                              
    je      TERMINAR
    cmp     bx, 2                              
    je      CAMBIACOLOR
    cmp     bx, 3                              
    je      TERMINAR
   
    GRAPH                   ;BORRAR
    mov     ax,0600h
    mov     bh,COLOR         ;nibble alto: color del fondo  / nibble bajo: color del texto
    mov     cx,0200h        ;Y,X ESQUINA SUPERIOR IZQUIERDA
    mov     dx,0450h        ;Y,X ESQUINA INFERIOR DERECHA
    int     10h 
    
    INC     X
    
    mov     ah,02h 
    MOV     DH,Y   
    MOV     DL,X         
    mov     bh,00h
    int     10h 
    
    IMPRIMIRCADENA CADENA1

    CMP     X,60
    JE      VOLVERINICIO 

            
    JMP     CHECK_MOUSE_BOTTONS

CAMBIACOLOR:
    
    CMP     COLOR,0FH
    JE      VOLVERAZUL
    INC     COLOR
    jmp     CHECK_MOUSE_BOTTONS 

VOLVERAZUL:
    MOV     COLOR,01H
    jmp     CHECK_MOUSE_BOTTONS 

VOLVERINICIO:
        
    GRAPH                   ;BORRAR
    mov     ax,0600h
    mov     bh,COLOR         ;nibble alto: color del fondo  / nibble bajo: color del texto
    mov     cx,0200h        ;Y,X ESQUINA SUPERIOR IZQUIERDA
    mov     dx,0450h        ;Y,X ESQUINA INFERIOR DERECHA
    int     10h 

    MOV     X,00H 
    
    JMP     CAMBIACOLOR      


TERMINAR:
    

ENDM 

CURSOR  MACRO
        MOV     AH,2
        MOV     DL,Xmsj
        MOV     DH,Ymsj
        INT     10H                 
ENDM


MENSAJE MACRO
      	MOV	    AH,9
        INT     21H                     
ENDM


TECLA  MACRO
       MOV      AH,01H
	   INT      21H
ENDM


IMPRIMIRCADENA MACRO CADENA       
    push    ds	
	pop     es	
	
	cld                        ; Activa DF para conteo ascendente en SI-DI
	mov si,offset cadena + 1
	lodsb				      ;extrae el byte con la cantidad de letras leidas desde el KB => AL
	
	mov ah,00h
	mov di,offset cadena + 2  ; DI contiene el inicio de la palabra
	
	add di,ax                 ;se suma al inicio de la palabra digitada
		                      ; se tiene ahora apuntando DI al final de la palabra
	mov al,'$'
	
	stosb
		
	MOV DX, OFFSET cadena + 2
	MOV AH, 09H
	INT 21H
	
ENDM  

;MACROS VIEJAS 
 

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



GRAPH MACRO               ;iniciamos modo grafico
            MOV AH,00H
            MOV AL,12H    ;640x480
            INT 10H
ENDM


   
 
 
.MODEL	SMALL			

.STACK	100H			

.DATA

	    X         DB     0
	    Y         DB     0 

        MS        DB    'Digite un texto: ','$'
	    cadena1   db     50,0,50 dup (0aah) 	    
	    Xmsj      DB     0
	    ymsj      DB     0
	    
        VELOCIDAD DW     0 
                          
        MENAZUL          DB      '[1] Azul','$'
        MENVERDE         DB      '[2] Verde','$'
        MENCIAN          DB      '[3] Cian','$'
        MENROJO          DB      '[4] Rojo','$'
        MENMAGENTA       DB      '[5] Magenta','$'
        MENMARRON        DB      '[6] Marron','$'
        MENCELESTE       DB      '[7] Celeste','$'
        MENAMARILLO      DB      '[8] Amarillo','$'
        MENBLANCO        DB      '[9] Blanco','$'
        MENCOLOR         DB      'Ingrese el numero del color de inicio que desea utilizar: ','$'  
                           
        COLOR            DB      0                   
.CODE				
	MOV	AX,@DATA
	MOV	DS,AX

    DISPLAY
	
	MOV	AH,4CH
	INT	21H

END

