Okay, so I can't craft an example right now, as my branch is currently broken :)  But basically, this is how you can intercept a call to read and overwrite it returned memory:

```
(defmethod call-return (name _ buf _ len)
  (when (and (= name 'read) (> len 0))
   (memset buf ?AA len)))
```

In general, you can intercept the program at any place and you have a full access to the interpreter state, so you can write anything and anywhere :)

Or, suppose, you have some concrete address and you want that it always return a specific value, then you can do

```
(defparameter *my-special-address* 0xDEADBEEF)

(defmethod loading (ptr)
  (when (= ptr *my-special-address*)
    (memory-write ptr 0xAA)))
```

and so on :)
