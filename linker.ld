ENTRY(_start)

SECTIONS
{
    . = 0x10000;

    .text : AT(0x10000) {
        *(.entry)
        *(.text)
        *(.text.*)
    }
    .data : { *(.data) }
    .bss  : { *(.bss) }
}
