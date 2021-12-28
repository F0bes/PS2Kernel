
// Seriously stupid. Any const char* will be put into .rodata.str1.8
// And for _whatever_ reason, the linker will complain about a relocation error
// So this is my workaround.
#define kstringconst __attribute__((section(".rodata"))) const char*

// Doesn't get put into .rodata.str1.8
#define kstring const char* const