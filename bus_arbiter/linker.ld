ENTRY(_start)

SECTIONS
{
    . = 0x10;
    .text :
    {
        *(.text)
    }

    . = 0x40;
    .data :
    {
        *(.data)
    }

    _end = .;
    _end_of_dummy_mem = 0x40;
}
