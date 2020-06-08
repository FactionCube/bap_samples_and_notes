https://gitter.im/BinaryAnalysisPlatform/bap

Another example from gitter:

Ivan Gotovchits
@ivg

There is a new way to detect null pointer dereference with very few false positives. 
You can now call SMT solver from Primus Lisp, e.g.,

```
;; file symbolic-null-pointer-dereference.lisp
(require posix)

(defmethod loading (ptr)
    (symbolic-assert 'null-pointer-dereference (> ptr 0x1000)))
```

then you can run your analysis as

```
bap ./exe --run --primus-lisp-load=symbolic-null-pointer-dereference --run-system=bap:symbolic-executor \
--run-entry-points=all-subroutines --primus-print-obs=assert-failure,pc-changed
```

and it will use the symbolic executor to explore the program state and every time 
there is a dereference from a pointer which value could probably belong to the NULL 
page, you will have an address and the model (the values of the input variables 
that are needed for the assertion to be false).

