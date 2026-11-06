[BITS 16]
[ORG 0x7C00]

start:
    cli
    mov ax, 0x0000
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, msg_loading
    call print_string

    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov bx, 0x1000
    mov es, bx
    mov bx, 0x0000
    int 0x13
    jc disk_error

    jmp 0x1000:0x0000

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

msg_loading db 'Loading C++ Kernel... (Please dont turn of your vm)', 13, 10, 0
msg_error   db 'Disk read error!', 13, 10, 0

times 510-($-$$) db 0
dw 0xAA55