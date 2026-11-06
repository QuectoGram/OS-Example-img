ENTRY(_start)

SECTIONS
{
    . = 0x10000;

    .text : {
        *(.entry)
        *(.text)
        *(.text.*)
    }
    .data : { *(.data) }
    .bss  : { *(.bss) }
}
