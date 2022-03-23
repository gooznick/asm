IFDEF RAX

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; x64 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PUBLIC print_line
PUBLIC mainAsm
EXTERN printAt:proc
EXTERN printStr:proc
EXTERN getChar:proc
EXTERN printPixel:proc

.data

    question db "Which character to write ?",0

.code


mainAsm PROC
  call        print_line 
  xor         rax,rax  ; return 0 
  ret 
mainAsm ENDP

print_line PROC

    ; prolog, make new call frame
    push    rbp       ; save old call frame
    mov     rbp, rsp  ; initialize new call frame

    ; print question on screen
    push    7h
    lea rbx, question
    push    rbx
    push    2
    push    15
    call    printStr 

    ; get the character to print on screen
    call getChar ; result in eax

    ; print char on screen
    push rax
    push rbx
    mov ebx,15
loop_1:
    push    7h
    push    rax
    push    rbx
    push    rbx
    call    printAt    ; call subroutine (_stdcall), print a single char
    dec rbx
    jnz loop_1
    mov ebx,255

loop_2:

    mov rax, 0ff0000h

    or rax, rbx
    push    rax
    push    rbx
    push    rbx
    call printPixel
    dec rbx
    jnz loop_2

    pop rbx
    pop rax


    ; epilog, restore old call frame
    mov     rsp, rbp  ; most calling conventions dictate ebp be callee-saved,
    pop     rbp       ; restore old call frame
    ret

print_line ENDP

ENDIF

END