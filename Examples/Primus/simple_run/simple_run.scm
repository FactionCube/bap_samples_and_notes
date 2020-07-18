
(option run-entry-points main a b )

(option primus-lisp-channel-redirect
	<stdin>:$prefix/stdin
	<stdout>:$prefix/stdout)

(option passes
	run)

(option report-progress)
(option log-dir log)

(option primus-print-output incidents)
(option primus-print-obs
	call
	incident
	incident-location)

