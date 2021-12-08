EE_OBJS	= KernelLoader.o
EE_BIN = KernelLoader.elf
EE_LIBS = -lkernel

all: build_kernel $(EE_BIN)

build_kernel:
	$(MAKE) -C Kernel
	bin2c Kernel/kernel.bin kernelbin.c kernelbin

clean:
	rm -f $(EE_BIN) $(EE_OBJS)
	rm -f kernelbin.c 
	$(MAKE) -C Kernel clean

run: $(EE_BIN)
	ps2client execee host:$(EE_BIN)

emu: $(EE_BIN)
	~/PCSX2/bin/PCSX2 --elf="$(shell pwd)/$(EE_BIN)"

reset:
	ps2client reset
	ps2client netdump

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
