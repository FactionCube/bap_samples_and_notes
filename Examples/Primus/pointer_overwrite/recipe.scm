;; I think you can match the 'depth' against 'clock' counts, which 
;; appear in the 'incidents' file.  Handy to know if you don't see
;; lisp commands in the output.
(parameter depth 2900  "a depth of analysis")
(parameter entry-main main "")
(parameter entry-points all-subroutines "where to search")
(parameter optimization 0 "optimization level")
(parameter maxvisited 128  "maximum number of executions of the same block")

;;(option primus-random-generators "((var RCX)  static 0xa5a5a5A5)" )
(option primus-lisp-load
  posix
  setup
)

(option primus-lisp-add "./lisp" )
(option passes
        run
	)

;;(option primus-random-init registers.lisp)

(option primus-lisp-channel-redirect
  <stderr>:$prefix/stderr
  <stdin>:$prefix/stdin
  <stdout>:$prefix/stdout)

(option report-progress)
(option log-dir log)

(option run-entry-points
	${entry-main}
	)
(option constant-tracker-enable)

;;(option primus-promiscuous-mode)
(option primus-greedy-scheduler)
(option primus-print-output incidents)
(option primus-limit-max-length $depth)
(option primus-limit-max-visited $maxvisited )
;;(option primus-random)

(option primus-print-obs
;;	all
  call
  call-return
  lisp-message
  stored
  written
  pc-changed
  loading
  read
  )

;;(option api-path "./api")


(option optimization-level $optimization)
