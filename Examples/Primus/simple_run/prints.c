// gcc -fcf-protection=none prints.c
#include <stdio.h>

void a () {
	printf ("a\n");
}

void b () {
	printf ("b\n");
}


int main () {

	a();
	b();
	return 0;;
}


