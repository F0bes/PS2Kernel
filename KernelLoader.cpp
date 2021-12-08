#include <kernel.h>
#include <stdio.h>

#include "kernelbin.c"

int main(int argc, char **argv)
{
	// Initialize the kernel
	printf("Preparing the kernel...\n");

	DIntr();

	for(int i = 0; i < size_kernelbin; i++)
	{
		*(unsigned char *)(0x80001000 + i) = kernelbin[i];
	}
	
	printf("Going to jump to the kernel now.\n");

	asm("j %0":: "r"(0x80001000));
	
SleepThread();
}