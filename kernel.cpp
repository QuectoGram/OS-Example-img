extern "C" void kernel_main(void) {
    char *video_memory = (char*) 0xB8000;
    const char *str = "Welcome to OSExample";
    int i = 0;
    while (str[i] != '\0') {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x1F;
        i++;
    }
    while (1) {
    }
}

__asm__(
    ".code16\n"
    ".global _start\n"
    "_start:\n"
    "    call kernel_main\n"
    "    cli\n"
    "0:  hlt\n"
    "    jmp 0b\n"
);
