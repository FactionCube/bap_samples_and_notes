If you wish to skip a function in Primus, i.e., go straight to ret, then do this in Primus Lisp:

Where you have some function bar: `call @bar with return %00000993`

```
(defun bar (input)
  (declare (external bar)
  (when (strcmp (input "PASSWORD"))
    (exec-addr %00000993)))
```
