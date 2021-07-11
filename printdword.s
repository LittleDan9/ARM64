//
// Assembler program to print a register in hex
// to stdout
//
// X0-x2 - paramters to linux function services
// X1 - is also address of byte we are writting
// X4 - register to print
// W5 - loop index
// W6 - current character
// X8 - linux function number
//
.global _start      // Provide program starting address
_start:
    MOV     X4, #0x6E3A
    MOVK    X4, #0x4F5D, LSL #16
    MOVK    X4, #0xFEDC, LSL #32
    MOVK    X4, #0x1234, LSL #48
    LDR     X1, =hexstr // Start of String
    ADD     X1, X1, #17 // Start at least sig digit
    // The loop is: FOR W5 = 16 to 1 STEP -1
    MOV     W5, #16 //16 digits to print`

loop:
    AND     W6, W4, #0xf // Mask of least sig digit
    // IF W6 >= 10 THEN GOTO LETTER
    CMP     W6, #10     // is 0-9 or A-F
    B.GE    letter
    // ELSE it's a number so convert an ASCII digit
    ADD     W6, W6, #'0'
    B       cont // goto end if

letter:
    ADD     W6, W6, #('A'-10)

cont: // end if
    STRB    W6, [X1]    // Store ASCII digit
    SUB     X1, X1, #1 s    // decrement address for next digit
    LSR     X4, X4, #4  // shit off the digit
    // next W5
    SUBS    W5, W5, #1  //Step W5 by -1