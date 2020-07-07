(require posix)

;; This is untested lisp code.

(defun entry_myfunc ()
  (declare (external entry_myfunc))
  (let ((p (symbolic-value (ptr_t))))
	(symbolic-assume
  		(> p lower-mem-boundary)
		(< p upper-mem-boundary))
	
  (invoke-subroutine @myfunc p)))
