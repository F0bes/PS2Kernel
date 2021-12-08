GCC = mips64r5900el-ps2-elf-gcc
LD = mips64r5900el-ps2-elf-ld
all:
	$(GCC) -ffreestanding -c -o bootstrap.o bootstrap.S -O2
	$(GCC) -ffreestanding -c -o kernelmain.o kernelmain.c -O2
	$(GCC) -ffreestanding -c -o stdout.o stdout.c -O2
	$(LD) -T linker.ld --oformat binary

clean:
	rm -f bootstrap.o
	rm -f kernelmain.o
	rm -f stdout.o
	rm -f kernel.bin

