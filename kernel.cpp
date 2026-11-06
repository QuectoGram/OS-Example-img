extern "C" void kernel_main(void) {
    const char* str = "Welcome to OSExample";
    for (int i = 0; str[i] != '\0'; ++i) {
        char c = str[i];
        __asm__ volatile (
            "movb %0, %%al\n\t" 
            "movb $0x0E, %%ah\n\t"
            "int $0x10"
            :
            : "r"(c)
            : "ax"
        );
    }

    while (1) {
        __asm__ volatile ("hlt");
    }
}

__asm__(
    ".code16\n"
    ".global _start\n"
    "_start:\n"
    "    xor %ax, %ax\n"
    "    mov %ax, %ds\n"
    "    mov %ax, %es\n"
    "    call kernel_main\n"
    "    cli\n"
    "0:  hlt\n"
    "    jmp 0b\n"
);
