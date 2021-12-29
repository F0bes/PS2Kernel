.extern kputs
.extern kernelmain

.global startkernel

startkernel:
la $a0, str_prompt
jal kputs
nop

jal kernelmain

end:
b end


.section .data

str_prompt: .asciz "startkernel: going to start the kernel :)\n"
