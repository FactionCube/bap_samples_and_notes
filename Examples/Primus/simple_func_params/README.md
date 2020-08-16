Run as `bap ./test --recipe=recipe.scm` and then examine the incidents file for expressions of the `func0` function.

```
grep func0 incidents
(call (func0 0x99 0x88 0x77))
(call-return (func0 0x99 0x88 0x77 0x77))
(call-return (func0 0x99 0x88 0x77 0x88))
```

The final number in each of the above calls is the return value from running the function, and the parameters to `func0()` are as given within `test.c`.  However, you can easily override these by way of a lisp-file definition for the `func0()` entry, as follows:

(defun entry-func0 () 
   (declare (external entry-func0)) (
   invoke-subroutine @func0 0x66 0x77 0x88 ))

and by replacing this line in `recipe.scm`

	(parameter entry-points all-subroutines "where to search")

with a specific call to your tailored `entry.lisp` function:

	(parameter entry-points entry-func0 "where to search")

The prototype for `func0()` needs to be specified in a header file, which you can see within `/api/func0.h`.

Now, when you run bap as above, the `incidents` file shows the supplied parameter values as appear in the `entry.lisp` file.

```
grep func0 incidents
(call (entry-func0))
(call (func0 0x66 0x77 0x88))
(call-return (func0 0x66 0x77 0x88 0x77))
(call-return (entry-func0 0x77))
(call-return (func0 0x66 0x77 0x88 0x88))
(call-return (entry-func0 0x88))
```

By the way, if you use `(parameter entry-points func0 "where to search")` in `recipe.scm`, then the parameters to `func0()` will be random 64-bit numbers, as supplied by Primus, because you won't get to the point of calling `func0(0x99,0x88,0x77)` from `main()`.

