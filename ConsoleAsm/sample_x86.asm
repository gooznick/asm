IFDEF RAX

ELSE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; x86 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.386 

.model flat, C  
PUBLIC print_line
PUBLIC mainAsm
EXTERN printAt:proc
EXTERN printStr:proc
EXTERN getChar:proc
EXTERN printPixel:proc
.data


align   4

    question db "Which character to write ?",0

.code

mainAsm PROC
  call        print_line 
  xor         eax,eax  
  ret 
mainAsm ENDP

print_line PROC

    ; prolog, make new call frame
    push    ebp       ; save old call frame
    mov     ebp, esp  ; initialize new call frame

    ; print question on screen

    push    7h
    lea ebx, question
    push    ebx
    push    2
    push    15
    call    printStr 

    ; get the character to print on screen
    call getChar ; result in eax

    ; print char on screen
    push ebx

    mov ebx,15  
loop_1:
    push    7h
    push    eax
    push    ebx
    push    ebx
    call    printAt    ; call subroutine (_stdcall), print a single char
    dec ebx
    jnz loop_1
    mov ebx,255

loop_2:
    mov eax, 0ff0000h
    or eax, ebx
    push    eax
    push    ebx
    push    ebx
    call printPixel
    dec ebx
    jnz loop_2
    pop ebx


    ; epilog, restore old call frame
    mov     esp, ebp  ; most calling conventions dictate ebp be callee-saved,
    pop     ebp       ; restore old call frame
    ret

print_line ENDP



ENDIF

END