IFDEF RAX

ELSE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; x86 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.386 

.model flat, C  
PUBLIC printAt
PUBLIC getChar@0
PUBLIC getChar
PUBLIC printPixel
EXTERN printCharWin32:proc
EXTERN printStrWin32:proc
EXTERN getCharWin32:proc
EXTERN printPixelWin32:proc
.data



.code

getChar@0 PROC
    jmp getChar    
getChar@0 ENDP

getChar PROC
    push    ebp     
    mov     ebp, esp  

    ; the procedure may change eax, ecx edx so we must store them
    push ecx
    push edx

    call    getCharWin32   

    ; restore scratchpad registers
    pop edx
    pop ecx

    ; restore old call frame
    mov     esp, ebp
    pop    ebp
    ret
    
getChar ENDP

printAt PROC

    ; make new call frame
    push    ebp       ; save old call frame
    mov     ebp, esp  ; initialize new call frame
    ; push call arguments, in reverse


    ; the procedure may change eax, ecx edx so we must store them
    push eax
    push ecx
    push edx

   loop_1:
    push    [ebp+20]
    push    [ebp+16]
    push    [ebp+12]
    push    [ebp+8]
    call    printCharWin32    ; call subroutine 
    add     esp, 16   ; remove call arguments from frame


    ; restore scratchpad registers
    pop edx
    pop ecx
    pop eax

    ; restore old call frame
    mov     esp, ebp
    pop    ebp
    ret 16

printAt ENDP

printPixel PROC
    ; make new call frame
    push    ebp       ; save old call frame
    mov     ebp, esp  ; initialize new call frame
    ; push call arguments, in reverse
    ; the procedure may change eax, ecx edx so we must store them

    push eax
    push ecx
    push edx
    push    [ebp+16]
    push    [ebp+12]
    push    [ebp+8]
    call    printPixelWin32    ; call subroutine 
    add         esp,12
    ; restore scratchpad registers
    pop edx
    pop ecx
    pop eax
    
    ; restore old call frame
    mov     esp, ebp
    pop    ebp
    ret 12
printPixel ENDP
printStr PROC

    ; make new call frame
    push    ebp       ; save old call frame
    mov     ebp, esp  ; initialize new call frame
    ; push call arguments, in reverse


    ; the procedure may change eax, ecx edx so we must store them
    push eax
    push ecx
    push edx

    push    [ebp+20]
    push    [ebp+16]
    push    [ebp+12]
    push    [ebp+8]
    call    printStrWin32    ; call subroutine 
    add     esp, 16   ; remove call arguments from frame


    ; restore scratchpad registers
    pop edx
    pop ecx
    pop eax

    ; restore old call frame
    mov     esp, ebp
    pop    ebp
    ret 16

printStr ENDP

ENDIF

END