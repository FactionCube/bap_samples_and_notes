Control is passed to your function `my_start`, because it overloads `_start`.

```
(defun my_start ()
   (declare (external "_start"))
   (let ((argc ...) (argv ...))
      (invoke-subroutine @main argc argv)))
```
