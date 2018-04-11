.data
hello:
    .word 0x12345678

.text
.globl _start
_start:
    lb a0, hello
finish:
    jal a4, finish
