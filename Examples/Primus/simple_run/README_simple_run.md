Compile as follows : `gcc -fcf-protection=none prints.c`
The new control flow enforcement technology from Intel, puts an 
`endbr` instruction at the beginning of each function.  Primus
will endlessly loop unless you compile as above.

`bap ./prints --recipe=simple_run.scm`

Output from the functions will appear in `stdout`.
I had to add `primus-greedy-scheduler` to get output from the two 
functions - leave it out and you only get the first called function's
output.
