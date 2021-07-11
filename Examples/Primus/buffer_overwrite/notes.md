The comparison is at 4012dc where you can capture the ZF (which is 1 on a match).

Registers to print are:
4012d3 RSI
4012dc RDI

(pc-changed 0x4012D3:64u)
(loading 0x3FFFFF39:64u#9685)
(loading 0x3FFFFF38:64u#9683)
(written (RSI 0xBBBB:64u#9688))  <-- capture
(pc-changed 0x4012D6:64u)
(written (R8 0xC4:64u#9689))    <--- capture

(pc-changed 0x4012DC:64u)
(written (ZF 0:1u#9724))  <-- capture

Try this code:

(defun memory-written (a x)
            (declare (advice :before memory-write))
            (msg "write $x to $a"))

(defmethod pc-changed (addr)
          (when (= addr '0x4012DC)
	  (memory-written _ ZF)
            (msg "pc-changed($0) was called" addr)))
