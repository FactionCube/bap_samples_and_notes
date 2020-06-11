(require posix)

(defmethod call-return (name size ptr)
  (when (= name 'malloc)
    (taint-introduce-directly 'mallocated ptr)))


