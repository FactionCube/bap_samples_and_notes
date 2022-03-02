// clang far_ptr.c
#include <stdio.h>
#include <sys/types.h>

int main () {

	// far_ptr points to memory defined elsewhere, which has not been malloc'd within 
	// this process.  This is to allow us to demonstrate hijacking the pointer using bap.
	u_int8_t * far_ptr = (u_int8_t *) 0x00180000;
	u_int8_t * bufcpy = NULL;
	bufcpy = far_ptr;
	
	int i;
	/* Should see 'ABCDEFGH' in stdout file when you run 'bap ./far_ptr --recipe=recipe.scm'.
	 * Just runnin far_ptr results in a seg fault.. */
	for (i = 0 ; i < 8; i++)
	{
		putchar(*(bufcpy + i));
	}
	return 0;
}

