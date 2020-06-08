;; This is Ivan Gotovchit's example lisp for tainting a specific 
;; pointer location.

(defmethod init ()
  (taint-policy-select 'bad-variable 'propagate-by-computation))

(defmethod loaded (ptr val)
  (when (= ptr 0x201014)
    (taint-introduce-directly 'bad-variable val)))

