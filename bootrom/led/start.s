.globl _start
.text
_start:
    la      t0, _riscv_test_end
    csrw    mtvec,t0
    la      sp, _stack_end
    jal     x1, main

_riscv_test_end:
    li      a4, 1
    li      a5, 0
    lui     a5, 0x80000
    slli    a6, a4, 12
    add     a5, a5, a6
_write_result:
    sw      a4, 0(a5)
    j _write_result
