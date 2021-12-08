.extern kernelmain

.global _start

_start:
jal kernelmain

nop
nop
_loop:
b _loop
