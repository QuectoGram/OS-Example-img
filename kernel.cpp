extern "C" void kernel_main(void) {
    volatile char *video_memory = (volatile char*) 0xB8000;
    const char *str = "Welcome to OSExample";
    int i = 0;
    
    while (str[i] != '\0') {
        video_memory[i * 2]     = str[i];
        video_memory[i * 2 + 1] = 0x1F; // White text on blue background
        i++;
    }
    
    while (1) {
        __asm__ volatile ("hlt");
    }
}

