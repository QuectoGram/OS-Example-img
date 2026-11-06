import os
import subprocess
def run_cmd(cmd):
    result = subprocess.run(cmd, shell=True)
    if result.returncode != 0:
        raise RuntimeError(f"Command failed: {cmd}")
def build():
    run_cmd("nasm -f bin boot.asm -o boot.bin")
    run_cmd("g++ -ffreestanding -fno-exceptions -fno-rtti -c kernel.cpp -o kernel.o -m32")
    run_cmd("objcopy -O binary kernel.o kernel.bin")

    with open("boot.bin", "rb") as f:
        boot_code = f.read()
    
    with open("kernel.bin", "rb") as f:
        kernel_code = f.read()

    if len(boot_code) != 512:
        raise ValueError(f"Bootloader must be exactly 512 bytes, got {len(boot_code)}")

    disk_image = bytearray(1474560)
    disk_image[0:512] = boot_code
    
    kernel_offset = 512
    disk_image[kernel_offset:kernel_offset + len(kernel_code)] = kernel_code

    with open("osexample.img", "wb") as f:
        f.write(disk_image)

    print("Successfully generated 'osexample.img'!")

if __name__ == "__main__":
    build()