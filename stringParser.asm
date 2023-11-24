section .data
    secondary db 'bruh',0

section .bss
    input resb 16
    char resb 1

section .text
    global _start

    _start:

        mov rax, 0
        mov rdi, 0
        mov rsi, input
        mov rdx, 16
        syscall

        mov rcx, 0
        mov rax, input
        push rax
    _printCharLoop:
        pop rax
        cmp byte [rax], 10
        je _done

        mov rsi, rax
        inc rax
        push rax
        mov rax, 1
        mov rdi, 1
        mov rdx, 1
        syscall
        jmp _printCharLoop

    _done:
        mov rax, 60
        mov rdi, 0
        syscall

