(defmethod eval-cond (c)
  (let ((t (taint-get-direct 'untrusted c)))
    (when t
      (dict-add 'untrusted/checked t (incident-location)))))

(defmethod call-return (name fd ptr _ len)
  (when (and (= name 'read) (> len 0))
    (taint-introduce-indirectly 'bad-read ptr len)))

(defmethod eval-cond (c)
  (when (taint-get-direct 'bad-read c)
    (incident-report 'bad-read-controlled-branch
                     (incident-location))))

