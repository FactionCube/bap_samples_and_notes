(require posix)

(defmethod call-return (name _ buf len _)
  (when (and (= name 'read) (> len 0))
   (memset buf ?a len)))
