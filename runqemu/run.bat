@echo off
qemu-system-i386 -machine pc -drive file=osexample.img,format=raw,if=floppy
pause
