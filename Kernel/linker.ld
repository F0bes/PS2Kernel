INPUT(
	kernelmain.o
	stdout.o
	stdout_c.o
	exceptions.o
  syscalls.o
)

SECTIONS
{
  .text.start (0x80001000) : {
    bootstrap.o( .text )
  }

  .text : ALIGN(0x1000) {
_TEXT_START_ = .;
    *(.text)
_TEXT_END_ = .;
  }

  .data : ALIGN(0x1000) {
_DATA_START_ = .;
    *(.data)
_DATA_END_ = .;
  }

  .bss : ALIGN(0x1000) {
_BSS_START_ = .;
    *(.bss)
_BSS_END_ = .;
  }
}

OUTPUT_FORMAT(binary);
OUTPUT(kernel.bin)