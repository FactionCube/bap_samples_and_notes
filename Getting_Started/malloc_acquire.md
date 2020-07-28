Ivan Gotovchits
@ivg
06:34  Jul 28, 2020

You can also try intercepting calls to `new` / `delete`

Basically, this is what is done for `malloc`,

```
(defmethod call-return (name len ptr)
  (when (and len ptr (= name 'malloc))
    (memcheck-acquire 'malloc ptr len)))
```

In other words, whenever you see a new memory region allocated, designated by 
`ptr`, `len` you shall call `(memcheck-acquire 'malloc ptr len)` on it.

And this is the glue code for `free`
```
(defmethod call (name ptr)
  (when (and ptr (= name 'free)
             (not (= ptr *malloc-zero-sentinel*)))
    (memcheck-release 'malloc ptr)))
```
