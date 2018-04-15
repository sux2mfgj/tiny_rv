.data
hello:
    .word 0x12345678

.text
.globl _start
_start:
    lw a0, hello
    addi a0, a0, 1
    add a2, x1, a0
finish:
    jal a4, finish
