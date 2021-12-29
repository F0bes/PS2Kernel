#include "syscalls.h"

void exceptions_init(void);

void kernelmain()
{
	exceptions_init();

	kprints("Using the syscall printer\n");
	kprinti(1234);
	kprintc('\n');

	while(1) {};
}