GCC = mips64r5900el-ps2-elf-gcc
GCCFLAGS = -ffreestanding -mabi=eabi -O1 
#32 relocation error
#o64 relocation error
#n32 broken addressing
#64 broken addressing
#eabi relocation error
#eabi + -mgp32 relocation error
LD = mips64r5900el-ps2-elf-ld
all:
	$(GCC) -c -o bootstrap.o bootstrap.S $(GCCFLAGS)
	$(GCC) -c -o kernelmain.o kernelmain.c $(GCCFLAGS)
	$(GCC) -c -o stdout.o stdout.c $(GCCFLAGS)
	$(LD) -T linker.ld --oformat binary 

clean:
	rm -f bootstrap.o
	rm -f kernelmain.o
	rm -f stdout.o
	rm -f kernel.bin

