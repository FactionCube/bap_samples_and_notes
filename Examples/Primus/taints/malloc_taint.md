June 10, 2020
@ivg - Ivan Gotovchits code from Gitter BAP.

$ cat example.c
#include <stdlib.h>

void foo(int *p){
  free(p);
}

int main(void) {
    foo(malloc(42));
}

$ make example
cc     example.c   -o example

$ cat taint-malloc.lisp
(require posix)

(defmethod call-return (name size ptr)
  (when (= name 'malloc)
    (taint-introduce-directly 'mallocated ptr)))

$ bap example --primus-lisp-load=taint-malloc --run --primus-print-obs=call,taint-attached | grep -B1 free
(taint-attached (Direct 1 0x201028:64u#1833))
(call (free 0x201028))


