OUTPUT_FORMAT("elf32-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

SECTIONS
{
    . = 0x80000000;
    .text   :
    {
        start.o(.text)
        *(.text)
    }
    . = 0x80002000;
    _stack_end = .;
}
