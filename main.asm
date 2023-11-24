%include "IOlib.asm"
%include "Calclib.asm"


section .data

section .bss
        input resb 32
        num1 resb 16
        num2 resb 16
        output resb 16

section .text
        global _start

_start:

    get_input input,32
    mov rdi,input
    call atoi
    mov rdi, rax
    call stoi
    mov r10, rax
    print r10, 32
    exit


