.extern kputs

.global kernelmain

kernelmain:
la $a0, str_prompt
jal kputs
nop

# Initialize stuff

jal exceptions_init
nop

la $a0, str_prompt2
li $a1, 0
syscall 1 # print string

la $a0, 12345
li $a1, 1
syscall 1 # print number

li $a0, 10
li $a1, 2
syscall 1 # printer charactor '\n'
syscall 1 # print it again because we preverse arguments :)


syscall 100 # invalid syscall


syscall 95
nop
ei
end:
b end


.section .data
str_prompt: .asciz "The PS2 kernel is alive!\n"
str_prompt2: .asciz "Kernel output using the new syscall handler!\n"
