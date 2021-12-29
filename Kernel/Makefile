AS = mips64r5900el-ps2-elf-as 
GCC = mips64r5900el-ps2-elf-gcc
# using n32 results in a problem with loading the HI part of an address
ASFLAGS = -mabi=eabi

LD = mips64r5900el-ps2-elf-ld

all:
	$(AS) -o bootstrap.o bootstrap.S $(ASFLAGS)
	$(AS) -o stdout.o stdout.S $(ASFLAGS)
	$(GCC) -o stdout_c.o stdout_c.c -mabi=eabi -ffreestanding -c
	$(AS) -o startkernel.o startkernel.S $(ASFLAGS)
	$(GCC) -o kernel.o kernel.c -mabi=eabi -ffreestanding -c
	$(AS) -o exceptions/exceptions.o exceptions/exceptions.S $(ASFLAGS)
	$(AS) -o exceptions/syscalls.o exceptions/syscalls.S $(ASFLAGS)
	$(LD) -T linker.ld
	python tools/sizeof.py kernel.bin

clean:
	rm -f bootstrap.o
	rm -f startkernel.o
	rm -f kernel.o
	rm -f stdout.o
	rm -f kernel.bin
	rm -f stdout_c.o
	rm -f exceptions/exceptions.o
	rm -f exceptions/syscalls.o


