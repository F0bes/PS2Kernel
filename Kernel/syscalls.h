#pragma once

// syscall 1 (kprint)

// a1 --|
//      v
//      0 -> a0 is ptr to string
//      1 -> a0 is number to print
//      2 -> a0 is char to print

typedef enum
{
	KP_STRING,
	KP_INT,
	KP_CHAR,
} KPRINT_MODE;

void kprint(char *str, KPRINT_MODE mode)
{
	volatile int g = 0;
	
	asm volatile(
		"syscall 1\n"
	:::"$a1");
	return;
}

#define kprints(str) kprint(str, KP_STRING)
#define kprinti(num) kprint(num, KP_INT)
#define kprintc(chr) kprint(chr, KP_CHAR)
