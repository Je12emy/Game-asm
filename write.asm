escribir macro ContieneHandle,EntradaDelFichero,MensajeDeMostramosError, GuardarEntradaTeclado, BufferLeerDisco, newl,score
    
    LOCAL LeemosElFichero, CerramosElFichero, MostramosError
    
    
    LEA   DX,EntradaDelFichero                  ;Lo que hacemos con estas instrucciones
    MOV   AH,9                                  ;es pasar a la pantalla, el contenido
    INT   21h   
    
    LEA   DX,GuardarEntradaTeclado              ; Puntero a la dirección para la entrada
    MOV   BYTE PTR [GuardarEntradaTeclado],60   ; Fijamos los 60 caracteres
    MOV   AH,10                                 ; función de entrada de teclado
    INT   21h                                   ; LLamar a la interrupción del DOS 
    
    MOV   BL,[GuardarEntradaTeclado+1]          ; Esta es la longitud efectiva tecleada
    MOV   BH,0              
    ADD   BX,OFFSET GuardarEntradaTeclado       ; apuntamos  al final
    MOV   BYTE PTR [BX+2],0                     ; ponemos el cero al final 
    
    LEA   DX,GuardarEntradaTeclado+2            ; offset 
    MOV   AL,2                                  ; Lo abrimos para  lectura
    MOV   AH,3Dh                                ; Esta función nos abrirá el fichero
    INT   21h                                   ; Y ahora llamamos al DOS
    JC    MostramosError                        ; Mirando los flags si CF=1 Mostrariamos un error
    MOV   ContieneHandle,AX                     ; En el buffer reservado guardamos  
    
    LeemosElFichero: 
        MOV   BX,ContieneHandle                 ;Movemos a BX el handle contenido en Contiene Hanndle        
        MOV   CX,2000                           ; 2000 será el número de bytes a leer
        LEA   DX,BufferLeerDisco                ; dirección del BufferLeerDisco
        MOV   AH,3Fh                            ; Esta función es para leer del fichero
        INT   21h                               ; Y aquí llamamos  al DOS
        JC    MostramosError                    ;Si el flag  CF=1 --> MostramosError
        MOV   CX,AX                             ; bytes leídos realmente
        JCXZ  CerramosElFichero                 ;Si es 0 leidos entonces no hay nada que i
        PUSH  AX                                ; preservarmos ax en La Pila
        LEA   BX,BufferLeerDisco                ; imprimir BufferLeerDisco ...
        
   ;SacamosPorPantalla: 
;        MOV   DL,[BX]                           ; carácter a carácter 
;        MOV   AH,2                              ; ir llamando al servicio 2 del
;        INT   21h                               ; DOS para imprimir en pantalla
;        INC   BX                                ; siguiente carácter
;        LOOP  SacamosPorPantalla                ; acabar caracteres
;        POP   AX                                ; recuperar nº de bytes leídos
;        CMP   AX,2000                           ; ¿leidos 2000 bytes?  
   ;LeemosElFichero:        
        MOV   BX,ContieneHandle                 ;Movemos a BX el handle contenido en Contiene Hanndle        
        MOV   CX,2 
   ;LEA   DX,BufferLeerDisco                    ;dirección del BufferLeerDisco
        LEA   DX,newl
        MOV   AH,40h                            ; Esta función es para escribir al archivo de texto
        INT   21h                               ; Y aquí llamamos  al DOS
        JC    MostramosError                    ;Si el flag  CF=1 --> MostramosError

   ;LeemosElFichero: 
        MOV   BX,ContieneHandle                 ;Movemos a BX el handle contenido en Contiene Hanndle        
        MOV   CX,50
                                                ;100 será el número de bytes a leer
   ;LEA   DX,BufferLeerDisco                    ;dirección del BufferLeerDisco
        LEA   DX,score
   ; lea   dx, bufferleerdisco
        MOV   AH,40h                            ; Esta función es para escribir al archivo de texto
        INT   21h                               ; Y aquí llamamos  al DOS
        JC    MostramosError                    ;Si el flag  CF=1 --> MostramosError 
         
    CerramosElFichero: 
         MOV   BX,ContieneHandle                ;Handle de acceso al fichero hilario.txt
         MOV   AH,3Eh                           ; CerramosElFichero 
         INT   21h                              ; Llamaremos  al DOS
         JC    MostramosError
                                                ; sI EL FLAG CF = 1, QUE ESTARÍA EN CY --> MostramosError
        jmp fin_escribir                             ; Y llegamos al fin del programa

    MostramosError: 
           
         LEA   DX,MensajeDeMostramosError       ;  MostramosError
         MOV   AH,9                             ; función de escribir en consola
         INT   21h                              ; Llamaremos al DOS
         CMP   ContieneHandle,0                 ;Coparamos si el handle está 0 "!fichero abierto"!
         JNE   CerramosElFichero
         jmp fin_escribir                            ; Y fin del programa 
   
   fin_escribir:
   
endm 




;****Macro para escribir el puntaje en un txt
;.model small
;.stack 100h
;.data 
;    ContieneHandle          DW    0        ; ContieneHandle de control del fichero
;    EntradaDelFichero       DB    13,10,"INTRODUCE EL NOMBRE DEL FICHERO: $"
;    MensajeDeMostramosError DB    13,10," MostramosError.Mira si has escrito bien el fichero ***",13,10,10,"$"
;    GuardarEntradaTeclado   DB    80 DUP (0)   ; BufferLeerDisco para leer desde el teclado
;    BufferLeerDisco         DB    2000 DUP (0) ;   "     "     "     "  el disco
;    newl                    DB    13,10
;    cadena1 db 50,0,50 dup(?)
;    score db "prueba_texto" 
;.code 
;    MOV AX,@DATA
;    MOV DS,AX
;    
;    escribir ContieneHandle,EntradaDelFichero,MensajeDeMostramosError, GuardarEntradaTeclado, BufferLeerDisco, newl,score
;    
;    
;    
;    mov ah,4ch
;    int 21h
;    mov ah,0ah                                  ;Leer un string de caracteres, queda en dx -> cadena1
;    lea dx,cadena1
;    int 21h
    
    
    ;LEA   DX,EntradaDelFichero                  ;Lo que hacemos con estas instrucciones
;    MOV   AH,9                                  ;es pasar a la pantalla, el contenido
;    INT   21h   
;    
;    LEA   DX,GuardarEntradaTeclado              ; Puntero a la dirección para la entrada
;    MOV   BYTE PTR [GuardarEntradaTeclado],60   ; Fijamos los 60 caracteres
;    MOV   AH,10                                 ; función de entrada de teclado
;    INT   21h                                   ; LLamar a la interrupción del DOS 
;    
;    MOV   BL,[GuardarEntradaTeclado+1]          ; Esta es la longitud efectiva tecleada
;    MOV   BH,0              
;    ADD   BX,OFFSET GuardarEntradaTeclado       ; apuntamos  al final
;    MOV   BYTE PTR [BX+2],0                     ; ponemos el cero al final 
;    
;    LEA   DX,GuardarEntradaTeclado+2            ; offset 
;    MOV   AL,2                                  ; Lo abrimos para  lectura
;    MOV   AH,3Dh                                ; Esta función nos abrirá el fichero
;    INT   21h                                   ; Y ahora llamamos al DOS
;    JC    MostramosError                        ; Mirando los flags si CF=1 Mostrariamos un error
;    MOV   ContieneHandle,AX                     ; En el buffer reservado guardamos  
;    
;    LeemosElFichero: 
;        MOV   BX,ContieneHandle                 ;Movemos a BX el handle contenido en Contiene Hanndle        
;        MOV   CX,2000                           ; 2000 será el número de bytes a leer
;        LEA   DX,BufferLeerDisco                ; dirección del BufferLeerDisco
;        MOV   AH,3Fh                            ; Esta función es para leer del fichero
;        INT   21h                               ; Y aquí llamamos  al DOS
;        JC    MostramosError                    ;Si el flag  CF=1 --> MostramosError
;        MOV   CX,AX                             ; bytes leídos realmente
;        JCXZ  CerramosElFichero                 ;Si es 0 leidos entonces no hay nada que i
;        PUSH  AX                                ; preservarmos ax en La Pila
;        LEA   BX,BufferLeerDisco                ; imprimir BufferLeerDisco ...
;        
;   ;SacamosPorPantalla: 
;;        MOV   DL,[BX]                           ; carácter a carácter 
;;        MOV   AH,2                              ; ir llamando al servicio 2 del
;;        INT   21h                               ; DOS para imprimir en pantalla
;;        INC   BX                                ; siguiente carácter
;;        LOOP  SacamosPorPantalla                ; acabar caracteres
;;        POP   AX                                ; recuperar nº de bytes leídos
;;        CMP   AX,2000                           ; ¿leidos 2000 bytes?  
;   ;LeemosElFichero:        
;        MOV   BX,ContieneHandle                 ;Movemos a BX el handle contenido en Contiene Hanndle        
;        MOV   CX,2 
;   ;LEA   DX,BufferLeerDisco                    ;dirección del BufferLeerDisco
;        LEA   DX,newl
;        MOV   AH,40h                            ; Esta función es para escribir al archivo de texto
;        INT   21h                               ; Y aquí llamamos  al DOS
;        JC    MostramosError                    ;Si el flag  CF=1 --> MostramosError
;
;   ;LeemosElFichero: 
;        MOV   BX,ContieneHandle                 ;Movemos a BX el handle contenido en Contiene Hanndle        
;        MOV   CX,50
;                                                ;100 será el número de bytes a leer
;   ;LEA   DX,BufferLeerDisco                    ;dirección del BufferLeerDisco
;        LEA   DX,score
;   ; lea   dx, bufferleerdisco
;        MOV   AH,40h                            ; Esta función es para escribir al archivo de texto
;        INT   21h                               ; Y aquí llamamos  al DOS
;        JC    MostramosError                    ;Si el flag  CF=1 --> MostramosError 
;         
;    CerramosElFichero: 
;         MOV   BX,ContieneHandle                ;Handle de acceso al fichero hilario.txt
;         MOV   AH,3Eh                           ; CerramosElFichero 
;         INT   21h                              ; Llamaremos  al DOS
;         JC    MostramosError
;                                                ; sI EL FLAG CF = 1, QUE ESTARÍA EN CY --> MostramosError
;         MOV   AH,4CH
;         INT   21h                              ; Y llegamos al fin del programa
;
;    MostramosError: 
;           
;         LEA   DX,MensajeDeMostramosError       ;  MostramosError
;         MOV   AH,9                             ; función de escribir en consola
;         INT   21h                              ; Llamaremos al DOS
;         CMP   ContieneHandle,0                 ;Coparamos si el handle está 0 "!fichero abierto"!
;         JNE   CerramosElFichero
;         MOV   AH,4CH                           ; sí: CerramosElFicherolo
;         INT   21H                              ; Y fin del programa
;end         
        
    
      