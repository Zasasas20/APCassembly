; Name: IOlib.asm
; Authors: Arga Atmaja, Zaid Al-Younis
; Version: 2.0
; This file contains functions and macros used for Input/Output related purposes


section .data

section .bss
        result resd 10
        strnum resb 16

; print (msg, len)
; Prints message into the console
%macro print 2
    save_state              ; Saves state of registers

    mov rax,1               ; SysCallWrite
    mov rdi,1               ; Stream Output
    mov rsi,%1;             ; Output Message
    mov rdx,%2              ; Length of message
    syscall

    restore_state           ; Restore state of registers
%endmacro

; save_state()
; Saves the current state of main registers by pushing them all to the stack
%macro save_state 0
    push rax
    push rdi
    push rsi
    push rdx
%endmacro

; restore_state()
; Restores the saved state of main registers by popping them all from the stack
%macro restore_state 0
    pop rdx
    pop rsi
    pop rdi
    pop rax
%endmacro

; get_input(&msg, len)
; Takes user input and stores it as a string in the msg container provided
%macro get_input 2
    save_state

    mov rax,0               ; SysCallRead
    mov rdi,0               ; stream input
    mov rsi,%1              ; Pointer to string
    mov rdx,%2              ; len of string
    syscall

    restore_state
%endmacro

; exit()
; Exits gracefully from the program
%macro exit 0
    mov rax, 60             ; SysCallExit
    mov rdi, 0              ; Error code of 0
    syscall
%endmacro

section .text

;Inputs:
;rdi: integer that needs to be converted to string
;Outputs:
;rax: string representation of integer
global stoi ;Stoi(int rdi)
    stoi:
        mov [result], rdi   ;move number to result
        mov rax,rdi         ;move number to rax
        cmp word [result], 0;compare to zero
        jge _notNegative    ;jump to _notNegative function if the comparison is greater
        neg rax             ;abs rax

        _notNegative:
            mov rcx, 0      ;make counter zero
            mov r10, 10     ;assign rbx register to 10

        _divideLoop:
            xor rdx, rdx    ;nullify rdx
            div r10         ;divide rax by 10

            push rdx        ;push number to stack
            inc rcx         ;increment to next number
        _break:
            cmp rax, 0      ;compare to zero
            jne _divideLoop ;jump to divideloop if not zero

            mov r10, strnum ;put address strnum to rbx
            mov r11, 0      ;start index zero

            cmp word [result],0 ;compare resilt to zero
            jge _popLoop    ;jump if result is positive

            mov byte [r10+r11], '-' ;add negative sign
            inc r11         ;increment index

        _popLoop:
            pop rax         ;pop remainder to rax
            add al, '0'     ;add al ascii
            mov [r10+r11], al ;store char at the index
            inc r11         ;incerement index
            loop _popLoop   ;jump to loop

            mov word [r10+r11],0 ;add null terminator
            mov rax, strnum ;mov strnum to rax
        ret

;Inputs:
;rdi: string that needs to be converted to integer
;Outputs:
;rax: integer representation of string
global atoi
    atoi:
        mov r10, 0          ;Initialize index with 0
        mov rax, 0          ;Initialize total with 0

        cmp byte [rdi], '-' ;Check if beginning character is a minus (indicating a negative int)
        jne _loop           ;Skip negative number handling
        mov r11, 1          ;Check negative flag to 1
        inc rdi             ;Increment index to skip
    _loop:
        cmp byte[rdi], 10   ;Check if our current character is a new line
        je _negativeCheck   ;End number processing
        cmp byte[rdi], 0    ;Check if our current character is end of line
        je _negativeCheck   ;End number processing

        mov r10b, byte [rdi];Extract current character

        sub r10, '0'        ;Transform character to int
        imul rax, 10        ;Multiply result with 10
        add rax, r10        ;Add int to total

        inc rdi             ;Go to next character
        jmp _loop           ;Loop again

    _negativeCheck:
        cmp r11, 1          ;Check if negative flag is on
        jne _done           ;Skip negative handling
        neg rax             ;Negate the result
    _done:
        ret                 ;Return from function

