OUTPUT_FORMAT("binary")
ENTRY(_start)
SECTIONS
{
    . = 0x10000; /* We load the kernel at segment 0x1000:0000 (0x10000 linear) */

    .text : {
        *(.entry)   /* Forces the assembly entry point to be first */
        *(.text)
    }
    .data : { *(.data) }
    .bss  : { *(.bss) }
}
