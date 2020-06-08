A taint example from gitter:

Ivan Gotovchits
@ivg
Jun 06 05:22

@lagarcia38, so I am back, let's do some analysis, let create a simple example,

// file input.c

int global_variable = 0;

int a(int x) {return x + 1;}
int b(int x) {return x * 2;}
int c(int x) {return x - 1;}
int d(int x) {return x / 2;}

int main(void) {
    int local_variable = 1;
    return
        a(b(global_variable)) +
        c(d(local_variable));
}

we will compile it as

gcc -g input.c -o input

We don't really need debug information for analysis, but it will help us, well to debug, 
Now let's run bap and see the IR as we would like to identify the address of the global variable:

$ bap input -dbir | grep -B4 'call @b'
00000588: RAX := pad:64[mem[0x201014, el]:u32]
0000058f: RDI := pad:64[low:32[RAX]]
00000598: RSP := RSP - 8
0000059b: mem := mem with [RSP, el]:u64 <- 0x658
0000059e: call @b with return %000005a0

here it is we read from the address 0x201014, good, now let's figure out which Primus 
system is suitable for us (I am using grep to minimize the output, of course, you can 
just read the whole output using less or redirect it to file),

$ bap primus-systems | grep taint
- bap:taint-analyzer:
  Uses promiscuous-executor for taint analysis.
  Propagates taint by computation.
- bap:exact-taint-analyzer:
  Uses promiscuous-executor for taint analysis.
  Propagates taint exactly.
- bap:reflective-taint-analyzer:
  A taint analyzer that reflects taints to/from BIR terms
- bap:base-taint-analyzer:
  Uses promiscuous-executor for taint analysis.

OK, sounds like a few, let's pick the first (looks good and has the shortest name :D) The 
plan is to run analysis, introduce taint when we read from that address and monitor all 
observations that are associated with taint. This is how you do analysis in Primus, you 
attach (or just grep) for certain events (called observations) and query the state/change 
it etc. It is like dynamic instrumentation. So what observations do we have? We can use 
bap primus-observations to get the full list of observations. Again, using grep and my 
innate ability to guess, let's search for something that is related to taint and to program 
counter,

$ bap primus-observations | grep -e 'taint\|pc'
- pc-changed:
- taint-finalize:
  Occurs when the taint becomes unreachable.
- taint-attached:
  Occurs when a taint is attached to the value.

Looks like that we can watch for pc-changed (which is for some reason undocumented!) 
and taint-attached, we then collect all addresses during which we had taint-attached 
to something. Those addresses will be tainted (of course, we can do this programmatically 
in Primus Lisp or OCaml, but let's start with simple grep). So, let's start running bap,

bap input --run --run-system=bap:taint-analyzer --primus-print-obs=taint-attached,pc-changed

We selected the system, we selected the two observations that we would like to watch, 
when we will run we will see the trace of execution, with no taint attached events, 
since we didn't introduce the taint yet, let's check this:

bap input --run --run-system=bap:taint-analyzer --primus-print-obs=taint-attached,pc-changed \
| grep -B1 taint-attached | grep pc-changed

Ok, now it is time to introduce the taint, we will use Primus Lisp for that,

(defmethod init ()
  (taint-policy-select 'bad-variable 'propagate-by-computation))

(defmethod loaded (ptr val)
  (when (= ptr 0x201014)
    (taint-introduce-directly 'bad-variable val)))

Some explanations. Primus observations are reflected to Primus Lisp signals that 
are handled by methods. In other words, every time an observation is triggered 
it fires the signal to the Lisp machine and matching methods are called. The first 
signal is init it is like the constructor, we need it to enable the default policy 
... because this new systems and components feature is very new, it was released 
only this week, and we forgot to enabled the default propagation policy :) But 
anyways, it is good to know that you can specify the propagation policy for each 
kind of taint that you would like to track. To be continued...
Ivan Gotovchits
@ivg
Jun 06 05:30

The next method is rather self-explanatory, when the value val is loaded from the 
pointer ptr if this pointer is our victim, then we introduce the taint. The main 
question is where to learn all these names. First of all, they are available online
... but it is always easier to get them from the command line, e.g., the list of 
primitives and signals available for our binary could be obtained using the 
--primus-lisp-documentation command, e.g.,

$ bap input --primus-lisp-documentation  | grep taint-introduce-directly -A1
** ~taint-introduce-directly~
(taint-introduce-directly K X) introduces a new taint of the
kind K that is directly associated with the value X

and

$ bap input --primus-lisp-documentation  | grep loaded
** ~loaded~
(loaded A X) is emitted when X is loaded from A

Ok, now it looks like that we are good to go. We need to load our lisp file (which we will name track.lisp),

$ bap input --run --run-system=bap:taint-analyzer --primus-print-obs=taint-attached,pc-changed \
--primus-lisp-load=track,posix | grep -B1 taint-attached | grep pc-changed
(pc-changed 0x64B:64u)
(pc-changed 0x651:64u)
(pc-changed 0x60D:64u)
(pc-changed 0x610:64u)
(pc-changed 0x613:64u)
(pc-changed 0x616:64u)
(pc-changed 0x658:64u)
(pc-changed 0x5FE:64u)
(pc-changed 0x601:64u)
(pc-changed 0x604:64u)
(pc-changed 0x608:64u)
(pc-changed 0x65F:64u)
(pc-changed 0x672:64u)

Great, we got the trace of tainted addresses!
