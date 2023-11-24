section .data
    number dd 70

section .bss
    result resd 10
    strnum resb 16

section .text
    global _start

    _start:

        mov rax, [number]
        sub rax, 20
        mov [result], rax

        cmp word [result], 0
        jge _notNegative
        neg rax

        _notNegative:
        mov rcx, 0
        mov rbx, 10

        _divideLoop:
            xor rdx, rdx
            div rbx

            push rdx
            inc rcx

            cmp rax, 0
            jne _divideLoop

        mov rbx, strnum
        mov rdi, 0

        cmp word [result], 0
        jge _popLoop

        mov byte [rbx+rdi], '-'
        inc rdi

        _popLoop:
            pop rax
            add al, '0'

            mov [rbx+rdi], al
            inc rdi
            loop _popLoop

            mov word [rbx+rdi], 0

        mov rax, 1
        mov rdi, 1
        mov rsi, strnum
        mov rdx, 16
        syscall

        mov rax, 60
        mov rdi, 0
        syscall