#include <stdio.h>

typedef unsigned char byte;

int func0 ( byte a, byte b, byte c)
{
	if ( a <= b ) 
	{
		return b;
	} else {
		return c;
	}
}

int main () {

	char ret = func0 ( 0x99 , 0x88 , 0x77);
	return 0;
}

