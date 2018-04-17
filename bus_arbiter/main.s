.data
hello:
    .word 0x12345678

.text
.globl _start
_start:
    lw a0, hello
    addi a0, a0, 1
    add a1, x0, a0
    add a2, a0, a1
finish:
    jal a4, finish
