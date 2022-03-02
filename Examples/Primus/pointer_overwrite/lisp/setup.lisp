(require posix)
(require pointers)
(require types)

;;(defparameter *stack-base* 0x40000000)
;;(defparameter *far_ptr* (- *stack-base* 0x10))
;;(defparameter *buf_ptr* (- *stack-base* 0x18))
(defparameter *malloc_ptr* 0x00000000)

(defmethod written (a b)
  (when 
    (and (= a 'RAX) (= b 0x180000) )
  (msg "WRITTEN $0 $1 " a b)
  ;; Using 'a' in lieu of 'RAX' didn't result in the register being over-written.
   (set RAX *malloc_ptr* )
  )
)

(defun bulk_read_and_msg (ptr)
    (let ((p ptr)
          (x (memory-read ptr))
          (n (-1 (sizeof int64_t))))
      (while n
             (incr p)
             (decr n)
             (set x (endian concat x (memory-read p))))
	      (msg ">>>>  $0 $1" (- p (-1 (sizeof int64_t))) x) )
   )


(defmethod init () 
  (let ((p (malloc 10) ))
 ;;   ((mem *buf_ptr* *buf_ptr*) static p)
  ;;  (msg "Woot  p: $0  *far_ptr*: $1 *buf_ptr*: $2" p *far_ptr* *buf_ptr* )
    ;; this is a test:
    (write-word int64_t p 0x4847464544434241)
;;  Don't use write-word: use 'set' to fill the register.
    ;;(write-word int32_t *buf_ptr* p)
    (set *malloc_ptr* p)
    ;;(msg "*buf_ptr* now has $0" (read-word ptr_t *buf_ptr* ))
    ;;(msg "*buf_ptr* now has $0" (memory-read *buf_ptr* ))
    (msg "*malloc_ptr* now has $0" (memory-read *malloc_ptr* ))
    (bulk_read_and_msg p)
  )
  )
 
;; This does not work - use 'set' instead, as shown above.

;;(defmethod read (reg value)
;;  ;;(when (and (= reg RCX) (= value 0x180000))
;;  (when (= reg RCX )
;;    (msg "hijack $0 $1" reg value)
;;;;    (write-word int32_t reg 0x00120000)
;;  )
;;  )

;; Unused here
;;(defun mylloc (size)
;;  (let ((ptr brk))
;;    (sbrk size)
;;    ptr))

;; Unused here
;;(defmacro write-block (addr bytes)
;;    (fold memory-write addr bytes))


