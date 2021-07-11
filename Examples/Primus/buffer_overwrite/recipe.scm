(parameter depth 64000  "a depth of analysis")
;; Over-ride the parameters within test.c for func0
;; with those which you set in the entry.lisp file.
(parameter entry-main main "")
(parameter entry-points all-subroutines "where to search")
(parameter optimization 0 "optimization level")
(parameter maxvisited 256 "maximum number of executions of the same block")

(option primus-lisp-load
;;  init
  posix
  types
  memory
  pointers
  setup
;;  string
;;  stdio
;;  simple-memory-allocator
;;  types
;;  pointers
;;  entry
;;  memory_read
)

(option primus-lisp-add "./lisp" )

(option passes
        run)

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

(option primus-print-obs
;;	all
  call
  call-return
  lisp-message
;;  stored
  written
  pc-changed
;;  loading
  read
  )

(option api-path "./api")

(option optimization-level $optimization)
