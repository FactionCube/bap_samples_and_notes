;; Example code straight from https://github.com/BinaryAnalysisPlatform/bap/pull/1105
;; Run like so:
;; bap eval-lisp main --primus-lisp-load example --system bap:symbolic-executor --primus-print-obs=assert-failure,call
;; It will give output like so:

;;(assert-failure (a1 (RDI #x0000000000000001)))
;;(assert-failure (a2 (RDI #x8000000000000000)))
;;(assert-failure (a4 (RDI #x0000000000000002)))
;;(call (main))
;;(assert-failure (a1 (RDI #x0000000000000002)))
;;(assert-failure (a2 (RDI #x8000000000000000)))

(defun main ()
  (declare (external "main"))
  (symbolic-assume (> RDI 0))
  (symbolic-assert 'a1 (= RDI 0))
  (symbolic-assert 'a2 (not (= (+ RDI RDI) 0)))
  (symbolic-assert 'a3 (not (= RDI 0)))
  (when (< RDI 16)
    (symbolic-assert 'a4 (= RDI 0))
    (symbolic-assert 'a5 (not (= (+ RDI RDI) 0)))
    (symbolic-assert 'a6 (not (= RDI 0)))))

