#include "stdout.h"

const char* text = "Some text!\n";
void kernelmain()
{
	kwrite("Hello, kernel!\n");
	kwrite(text);
	
	return;
}