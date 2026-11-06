[BITS 16]
[ORG 0x7C00]

start:
    cli
    mov ax, 0x0000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov ah, 0x02
    mov al, 5
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov bx, 0x1000
    mov es, bx
    mov bx, 0x0000
    int 0x13
    jc disk_error

    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:init_pm

disk_error:
    mov si, msg_error
    call print_string
    jmp hang

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

hang:
    cli
    hlt
    jmp hang

msg_error db 'Disk read error!', 13, 10, 0

[BITS 32]
init_pm:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000

    jmp 0x10000

gdt_start:
    dq 0x0000000000000000
gdt_code:
    dw 0xFFFF, 0x0000
    db 0x00, 10011010b, 11001111b, 0x00
gdt_data:
    dw 0xFFFF, 0x0000
    db 0x00, 10010010b, 11001111b, 0x00
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

times 510-($-$$) db 0
dw 0xAA55
