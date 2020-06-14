(require posix)

(defmethod loading (ptr)
  (symbolic-assert 'null-pointer-dereference )
)

(defmethod storing (ptr)
  (symbolic-assert 'null-pointer-dereference )
 )

