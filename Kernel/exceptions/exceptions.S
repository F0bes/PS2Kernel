.extern kputs
.extern kputc
.extern kputi

.global exceptions_init 

.extern syscall_table
# REPLACE VECTORS WITH V_* INSTRUCTIONS
# THEY JUMP TO THE HANDLER
V_COMMON:
j HANDLER_COMMON 

# VECTOR HANDLERS
HANDLER_COMMON:
mfc0 $k1, $13 # Cause
srl $t0, $k1, 2
andi $t0, $t0, 0xf # Exception code
move $k0, $t0 # Store the exception code for the handler
mul $t0,$t0, 4 # Offset to handler
la $t1, exception_table
add $t1, $t1, $t0
lw $t2, 0($t1)
jr $t2


# EXCEPTION HANDLERS | NEVER RETURN UNLESS USING ERET

# GENERIC EXCEPTION HANDLER
# USE THIS FOR UNIMPLEMENTED EXCEPTION HANDLERS
EXCEPTION_GENERIC:
la $a0, generic_msg
jal kputs
move $a0, $k0
jal kputi
li $a0, 10
jal kputc


# We can cheat and jump here and treat this like boilerplate exit code
EXCEPTION_GENERIC_PRE_END:
mfc0 $t0, $13 # Cause
mfc0 $k0, $14 # EPC
srl $t0, $t0, 31 # See if in delay slot
beqz $t0, EXCEPTION_GENERIC_END
nop
add $k0, $k0, -8 # Skip delay slot

EXCEPTION_GENERIC_END:
add $k0, $k0, 4
mtc0 $k0, $14 # EPC
eret


EXCEPTION_HANDLE_SYSCALL:
add $sp, $sp, -24
sw $a0, 0($sp)
sw $a1, 4($sp)
sw $a2, 8($sp)
sw $a3, 12($sp)
sw $ra, 16($sp)
sw $v1, 20($sp)
# 24 -> syscall number

# Uncomment the kputs,kputi, and kputc lines to see the syscall info
la $a0, syscall_msg
#jal kputs

mfc0 $a0, $14 # EPC
lw $a0, 0($a0) # Load the SYSCALL instruction that invoked the exception
srl $a0, $a0, 6 # Shift off the opcode bits
li $t1, 0xFFFFF
and $a0, $a0, $t1 # Mask off the SPECIAL number
sw $a0, 24($sp)
#jal kputi

la $a0, syscall_msg_end
#jal kputs

lw $a0, 20($sp) # regular sce kernel uses $v1 for syscall number
#jal kputi		# let's print it just because

# newline
li $a0, 10
#jal kputc
nop

lw $t1, 24($sp)
mul $t1, $t1, 4
la $t0, syscall_table
add $t0, $t0, $t1
lw $t0, 0($t0)	# handler for syscall is in $t0

# If the target address in the table is 0, then we have a syscall that
# is not implemented.
beqz $t0, _syscall_invalid
nop

# Restore arguments
lw $a0, 0($sp)
lw $a1, 4($sp)
lw $a2, 8($sp)
lw $a3, 12($sp)
jalr $t0 # Jump to the syscall handler

lw $ra, 20($sp) # Restore the return address
add $sp, $sp, 24
j EXCEPTION_GENERIC_PRE_END # This handles our exit jump

_syscall_invalid:

la $a0, syscall_msg_invalid
jal kputs
lw $a0, 24($sp)
jal kputi
li $a0, 10
jal kputc

j EXCEPTION_GENERIC_PRE_END




# INITIALIZATION
exceptions_init:
# set the common vector to jump to the handler
la $t0, V_COMMON
lw $k0, 0($t0) # load the jump instruction
la $k1, 0x80000180 # set the vector address
sw $k0, 0($k1) # store the jump instruction
addi $k1, $k1, 4 # set the vector delay slot address
sw $zero, 0($k1) # store the delay slot instruction (nop)
jr $ra

.section .data
syscall_msg: .asciz "Syscall exception. Code: "
syscall_msg_invalid: .asciz "Syscall exception. Code: Invalid: "
syscall_msg_end: .asciz " $v1: "
generic_msg: .asciz "Generic exception. (unhandled) Code: \n"

# table of handler functions
exception_table:
	.long EXCEPTION_GENERIC, EXCEPTION_GENERIC, EXCEPTION_GENERIC, EXCEPTION_GENERIC
	.long EXCEPTION_GENERIC, EXCEPTION_GENERIC, EXCEPTION_GENERIC
	.long EXCEPTION_GENERIC, EXCEPTION_HANDLE_SYSCALL, EXCEPTION_GENERIC
	.long EXCEPTION_GENERIC, EXCEPTION_GENERIC, EXCEPTION_GENERIC
	
	
