A demonstration of how to over-write a buffer pointer using `primus lisp`. The file, `setup.lisp`, shows how to do this. It will over-write a pointer defined within the executable with a pointer to a buffer which has been created by a call to `malloc` from within the lisp file.  Additionally, a string of bytes (`ABCDEFGH`) are written into the lisp buffer, and you can then see that they are printed to `stdout` when `bap` is run (`bap ./a.out --recipe=recipe.scm`). 


I think some of this code came from jtpaasch, though I can't recall where I sourced it from.
