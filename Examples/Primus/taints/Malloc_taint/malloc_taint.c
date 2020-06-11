#include <stdlib.h>

void foo(int *p){
  free(p);
}

int main(void) {
    foo(malloc(42));
}

