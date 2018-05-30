.data
hello:
    .word 0x12345678
to_store:
    .word 0x0

.text
.globl _start
_start:
    csrr a0,mhartid
    lw a0, hello
    addi a0, a0, 1
    add a1, x0, a0
    add a2, a0, a1
    la a5, to_store
    sb a0, 0(a5)
finish:
    jal a4, finish
