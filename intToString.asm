section .data
    number dw -20

section .bss
    space resb 100
    spacepos resb 8
    negative resb 1

section .text
    global _start

    %macro printDigit 1

        mov rax, [%1]
        cmp word [%1], 0
        call _isNegative
        mov rdx, 0

            %%assemble:
                mov rcx, space
                mov rbx, 10
                mov [rcx], rbx
                inc rcx
                mov [spacepos], rcx

            %%mainNumberLoop:
                mov rdx, 0
                mov rbx, 10
                div rbx
                add rdx, 48

                mov rcx, [spacepos]
                mov [rcx], dl
                inc rcx
                mov [spacepos], rcx

                cmp rax, 0
                jne %%mainNumberLoop

            cmp word [negative], 1
            call _addNegative

            %%secondaryLoop:
                mov rcx, [spacepos]

                mov rax, 1
                mov rdi, 1
                mov rsi, rcx
                mov rdx, 1
                syscall

                mov rcx, [spacepos]
                dec rcx
                mov [spacepos], rcx

                cmp rcx, space
                jge %%secondaryLoop



    %endmacro

    _start:
        printDigit number

        mov rax, 60
        mov rdi, 0
        syscall

    _isNegative:
        jle _negative
        ret
        _negative:
            mov rdx, 1
            mov [negative], rdx

            push rax
            mov rax, 65536
            pop rdx
            sub rax, rdx
            ret

    _addNegative:
        je _add
        ret
        _add:
            mov rcx, [spacepos]
            mov word [rcx], '-'
            inc rcx
            mov [spacepos], rcx
            ret