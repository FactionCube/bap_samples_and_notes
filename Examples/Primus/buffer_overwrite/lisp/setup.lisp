(require types)
(require pointers)


(defparameter *stack-base* 0x40000000)
(defparameter *data0*  (- *stack-base* 72) )
(defparameter *data1*  (- *stack-base* 200) )

;; Unused here
;;(defun mylloc (size)
;;  (let ((ptr brk))
;;    (sbrk size)
;;    ptr))

;; Unused here
;;(defmacro write-block (addr bytes)
;;    (fold memory-write addr bytes))


(defmethod init () )

;; Doesn't work
;;(defun memory-written (a x)
;;	(declare (advice :before memory-write))
;;        (msg "write $0 to $1" x a))


(defmethod read (v x)
  (when (or (= v 'RSI) (= v 'R8))
	(msg ">> $0 <-- $1" v x ))
 )

(defmethod written (flag value)
  (when (= flag 'ZF)    ;; must have the quote
	(msg ">> ZF <-- $0" value ))
  )


(defmethod pc-changed (addr)
  (when (= addr 0x4012DC)
     (msg "pc-changed ($0) was called " addr )
	)
 )
	  

(defmethod call-return (name buf _ len _ )
  (when (and (= name 'memset) (= len 0x38))
    (let ((p *data1*))
	(msg " start: p is $0" p )
;;    (write-word int64_t p 0xa1a2a3a4b1b2b3b4)
    (write-word int64_t p 0xa1a2a3a4b1b200c4)
    (+= p (sizeof int64_t))
    (write-word int64_t p 0xccccccccdddddddd)
    (+= p (sizeof int64_t))
    (write-word int64_t p 0xeeeeeeeeffffffff)
    (+= p (sizeof int64_t))
    (write-word int64_t p 0x1a1a1a1a1b1b1b1b)
    (+= p (sizeof int64_t))
    (write-word int64_t p 0x1c1c1c1c1d1d1d1d)
    (+= p (sizeof int64_t))
    (write-word int64_t p 0x1e1e1e1e1f1f1f1f)
    (+= p (sizeof int64_t))
    (write-word int64_t p 0x2020202021212121)
    ))
	(msg " end: p* is $0" *data1* )
	)

;; This is the original.
;;(defmethod call-return (name buf _ len _ )
;;  (when (and (= name 'memset) (= len 0x38))
;;    (let ((p *data1*))
;;	(msg " start: p is $0" p )
;;    (write-word int64_t p 0xfafebabe00020100)
;;    (+= p (sizeof int64_t))
;;    (write-word int64_t p 0x0807060504030201)
;;    (+= p (sizeof int64_t))
;;    (write-word int64_t p 0x100f0e0d0c0b0a09)
;;    (+= p (sizeof int64_t))
;;    (write-word int64_t p 0x1817161514131211)
;;    (+= p (sizeof int64_t))
;;    (write-word int64_t p 0x201f1e1d1c1b1a19)
;;    (+= p (sizeof int64_t))
;;    (write-word int64_t p 0xa17dcec3021c339b)
;;    (+= p (sizeof int64_t))
;;    (write-word int64_t p 0x8eff961f9c155fa2)
;;    ))
;;	(msg " end: p* is $0" *data1* )
;;	)


