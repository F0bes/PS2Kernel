.extern kputs
.extern kputi
.extern kputc


# Syscalls
# 0 -> Undefined, might try and be backwards compatible with the original kernel
# 1 -> Kernel print (a0 = string, a1 = type (0 = string, 1 = int, 2 = char))


syscall_print:

beqz $a1, _printstring
li $t0, 1
beq $a1, $t0, _printint
j kputc

_printstring:
j kputs

_printint:
j kputi





.section .data
.global syscall_table
syscall_table:
.long 0x0, syscall_print
.fill 99, 0x4, 0x0
kputs_msg:
.asciz "Hello, world!\n"

