void reverseString(char *str, int len)
{
	
	// Find the length of the string


	// Now reverse
	int i = 0;
	int j = len - 1;
	char temp;
	while(i < j)
	{
		temp = str[i];
		str[i] = str[j];
		str[j] = temp;
		i++;
		j--;
	}
}

void intToString(int number, char *string)
{
	int i, sign;
	
	if ((sign = number) < 0)
		number = -number;
	i = 0;
	do {
		string[i++] = number % 10 + '0';
	} while ((number /= 10) > 0);
	if (sign < 0)
		string[i++] = '-';
	reverseString(string,i);
	string[i] = '\0';
}