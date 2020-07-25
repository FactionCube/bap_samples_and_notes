;; We need to put this in a file that has the .asd extension, e.g., 
;; my-systems.asd and put this file somewhere on the search path of 
;; the primus-system plugin. The current working directory will work, 
;; but you can add a path using --primus-systems-add-path parameter. 
;; BTW - this taint example doesn't do a great deal; it shows only
;; how to implement your systems file.

;; Now, we can run any taint analysis and specify our system using --run-system=my:symbolic-taint-analyzer, e.g.,
;; 
;; bap ./exe --run \
;;    --run-system=my:symbolic-taint-analyzer \
;;    --primus-lisp-load=posix,check-value \
;;    --primus-print-obs=incident




(defsystem my:symbolic-taint-analyzer
  :description "analyzes taints using symbolic executor"
  :depends-on (bap:symbolic-executor)
  :components (bap:taint-primitives
               bap:taint-signals
               bap:propagate-taint-by-computation))

