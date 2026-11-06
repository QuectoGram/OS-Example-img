__asm__(
    ".section .entry\n"
    ".code16\n"
    ".global _start\n"
    "_start:\n"
    "    cli\n"
    "    data32 lgdt (gdt_descriptor)\n" 
    "    mov %cr0, %eax\n"
    "    or $1, %eax\n"
    "    mov %eax, %cr0\n"
    "    ljmp $0x08, $init_pm\n" 
    
    ".code32\n"
    "init_pm:\n"
    "    mov $0x10, %ax\n"
    "    mov %ax, %ds\n"
    "    mov %ax, %es\n"
    "    mov %ax, %fs\n"
    "    mov %ax, %gs\n"
    "    mov %ax, %ss\n"
    "    mov $0x90000, %esp\n"
    "    call _kernel_main\n" 
    "    cli\n"
    "1:  hlt\n"
    "    jmp 1b\n"

    ".align 4\n"
    "gdt_start:\n"
    "    .quad 0x0000000000000000\n" 
    "    .quad 0x00cf9a000000ffff\n" 
    "    .quad 0x00cf92000000ffff\n" 
    "gdt_end:\n"
    
    "gdt_descriptor:\n"
    "    .word gdt_end - gdt_start - 1\n"
    "    .long gdt_start + 0x10000\n" 
);

extern "C" void kernel_main(void) {
    volatile char *video_memory = (volatile char*) 0xB8000;
    const char *str = "Welcome to OSExample";
    int i = 0;
    
    while (str[i] != '\0') {
        video_memory[i * 2]     = str[i];
        video_memory[i * 2 + 1] = 0x1F; 
        i++;
    }
    
    while (1) {
        __asm__ volatile ("hlt");
    }
}

