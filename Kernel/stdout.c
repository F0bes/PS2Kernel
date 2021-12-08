void kwrite(const char* buffer)
{
	volatile char* const ee_serial_out = (volatile char*)0x1000F180;
	
	for(int i = 0; i < 255; i++)
	{
		if(buffer[i] == '\0')
		{
			break;
		}
		
		*ee_serial_out = buffer[i];
	}
	

	return;
}