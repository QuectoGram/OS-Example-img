inline void outb(unsigned short port, unsigned char val) {
    __asm__ volatile ("outb %0, %1" : : "a"(val), "Nd"(port));
}

inline unsigned char inb(unsigned short port) {
    unsigned char ret;
    __asm__ volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port));
    return ret;
}

extern "C" void kernel_main(void) {
    (void)inb(0x3DA);       
    outb(0x3C0, 0x30);      
    unsigned char mode = inb(0x3C1); 
    mode &= ~0x08;          
    outb(0x3C0, mode);      

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
