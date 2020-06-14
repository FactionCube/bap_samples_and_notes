(require posix)

(defmethod loading (ptr)
    (symbolic-assert 'null-pointer-dereference (> ptr 0x1000)))


(defmethod storing (ptr)
    (symbolic-assert 'null-pointer-dereference (> ptr 0x1000)))
