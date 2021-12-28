.global kputs
.global kputc
.global kputi

.extern intToString

.set EE_OUT, 0x1000F180

# a0, pointer to string
kputs:
la $t0, EE_OUT
_kputs_loop:
	lbu $t1, 0($a0)
	beqz $t1, _kputs_end # end of string
	nop
	addiu $a0, $a0, 1
	sb $t1, 0($t0)
	nop
	j _kputs_loop
_kputs_end:
jr $ra
nop

kputc:
la $t0, EE_OUT
sb $a0, 0($t0)
jr $ra
nop

# a0, number
kputi:
daddiu $sp,$sp,-4
sw $ra,0($sp)

la $a1, kputi_buffer
jal intToString
nop
la $a0, kputi_buffer
jal kputs
nop

lw $ra, 0($sp)
daddiu $sp,$sp,4
jr $ra


nop

.section .bss
.align 4
kputi_buffer: .space 32










