.extern kernelmain

.global _start

_start:

# The initial idea was to jump to C code but I can't get addressing to work w/ gcc
jal kernelmain

nop
nop
_loop:
b _loop
