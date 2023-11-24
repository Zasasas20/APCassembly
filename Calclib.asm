

section .data

section .bss

section .text

;Inputs:
;rdi: First number
;rsi: Second number
;Outputs:
;rax: Result of addition
global addition
    addition:
        xor r10,r10         ;initialize r10 to zero
        xor r11,r11         ;initialize r11 to zero

        cmp rdi,0           ;compare firs number to zero
        jge _second_cmp     ;if first number greater than zero jump to _second_cmp
        mov r10,1           ;if not greater make r10 1 for signed flag
        neg rdi             ;abs first number

    _second_cmp:
        cmp rsi,0           ;compare second number to zero
        jge _checks         ;if second number is greater than zero jumpt to _checks
        mov r11,1           ;if not greater than 0 make r11 1 for signed flag
        neg rsi             ;abs second number

    _checks:
        cmp r10,1           ;compare first number signed flag to 1
        jne _elseif         ;if its not equal jump to _elseif
            cmp r11,1       ;compare second number to signed flag to 1
            jne _else       ;if its not equal jumpt to _else
                add rsi,rdi ;add second number and first number
                mov rax,rsi ;move result to rax
                neg rax     ;abs result
                ret         ;returns
            _else:
                sub rsi,rdi ;subtract second number and first number
                mov rax,rsi ;move result of subtraction to rax
                ret         ;returns
        _elseif:
            cmp r11,1       ;compare second number signed flag to 1
            jne _final      ;if its not equal to 1 jump to _final
            sub rdi,rsi     ;subtracts first number and second number
            mov rax,rdi     ;move result to rax
            ret             ;returns
        _final:
            add rdi,rsi     ;adds first number and second number
            mov rax,rdi     ;move result to rax
            ret             ;returns


;Inputs:
;rdi: First number
;rsi: Second number
;Outputs:
;rax: Result of subtraction
global subtraction
    subtraction:
        neg rsi             ;abs second number
        call addition       ;call addition function
        ret                 ;returns

;Inputs:
;rdi: Dividend
;rsi: Divisor
;Outputs:
;rax: Quotient of division
;rdx: Remainder of division
global divisiom
    division:


