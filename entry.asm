[BITS 16]
SECTION .entry

global _start
extern _kernel_main

_start:
    cli
    
    db 0x0F, 0x01, 0x16, 0x20, 0x00
    
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    
    db 0x66, 0xEA
    dd 0x00010011
    dw 0x0008

[BITS 32]
init_pm:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000
    call _kernel_main
    cli
.hang:
    hlt
    jmp .hang

align 4
gdt_start:
    dq 0x0000000000000000
    dq 0x00cf9a000000ffff
    dq 0x00cf92000000ffff
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start + 0x10000
