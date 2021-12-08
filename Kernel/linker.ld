INPUT(
	kernelmain.o
	stdout.o
)

SECTIONS{
	. = 0x80001000;
	.text : {
		bootstrap.o(.text);
		*(.text);
	}

	.data : {
		*(.rodata .rodata.*);
		*(.data .data.*);
	}

	.bss : {
		*(.bss .bss.*);
	}
}

OUTPUT(kernel.bin)