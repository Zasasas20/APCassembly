section .data
    input_msg    db 'Enter a number: ', 10

section .bss
    result resd 10
    input resb 16
    strnum resb 16

section .text
    global _start

_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, input_msg
    mov rdx, 16
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 16
    syscall

    mov rsi, input ;address
    mov rdx, 0
    mov rax, 0

    cmp byte [rsi], '-'
    jne _NegativeNot
    mov r8, 1
    inc rsi
    _NegativeNot:
_loop:
    cmp byte[rsi], 10
    je _done

    mov dl, byte [rsi]

    sub rdx, '0'
    imul rax, 10
    add rax, rdx

    inc rsi
    jmp _loop

_done:
        cmp r8, 1
        jne _nullNegative
        neg rax
        _nullNegative:
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