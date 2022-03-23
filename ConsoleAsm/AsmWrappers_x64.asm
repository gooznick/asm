IFDEF RAX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; x64 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    push    rbp     
    mov     rbp, rsp  

    ; the procedure may change eax, ecx edx so we must store them
    push rcx
    push rdx

    call    getCharWin32   

    ; restore scratchpad registers
    pop rdx
    pop rcx

    ; restore old call frame
    mov     rsp, rbp
    pop    rbp
    ret
    
getChar ENDP

printAt PROC

    ; make new call frame
    push    rbp       ; save old call frame
    mov     rbp, rsp  ; initialize new call frame
    ; push call arguments, in reverse


    ; the procedure may change eax, ecx edx so we must store them
    push r8
    push r9
    push rax
    push rcx
    push rdx

   loop_1:
    mov    r9,[rbp+40]
    mov    r8,[rbp+32]
    mov    rdx,[rbp+24]
    mov    rcx,[rbp+16]
    call    printCharWin32    ; call subroutine 


    ; restore scratchpad registers
    pop rdx
    pop rcx
    pop rax
    pop r9
    pop r8

    ; restore old call frame
    mov     rsp, rbp
    pop    rbp
    ret 16

printAt ENDP



printPixel PROC

    ; make new call frame
    push    rbp       ; save old call frame
    mov     rbp, rsp  ; initialize new call frame
    ; push call arguments, in reverse


    ; the procedure may change eax, ecx edx so we must store them
    push r8
    push r9
    push rax
    push rcx
    push rdx

    mov    r8,[rbp+32]
    mov    rdx,[rbp+24]
    mov    rcx,[rbp+16]
    call    printPixelWin32    ; call subroutine 


    ; restore scratchpad registers
    pop rdx
    pop rcx
    pop rax
    pop r9
    pop r8

    ; restore old call frame
    mov     rsp, rbp
    pop    rbp
    ret 12

printPixel ENDP
printStr PROC

    ; make new call frame
    push    rbp       ; save old call frame
    mov     rbp, rsp  ; initialize new call frame
    ; push call arguments, in reverse

    ; the procedure may change eax, ecx edx so we must store them

    push r8
    push r9
    push rax
    push rcx
    push rdx

   loop_1:
    mov    r9,[rbp+40]
    mov    r8,[rbp+32]
    mov    rdx,[rbp+24]
    mov    rcx,[rbp+16]
    call    printStrWin32    ; call subroutine 


    ; restore scratchpad registers
    pop rdx
    pop rcx
    pop rax
    pop r9
    pop r8

    ; restore old call frame
    mov     rsp, rbp
    pop    rbp
    ret 16

printStr ENDP



ENDIF
END