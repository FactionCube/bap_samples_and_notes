From BAP gitter:

Ivan Gotovchits
@ivg
Nov 05 2019 04:30

Let me throw in some definitions, that might help you if they don't work then we will try to find something better.

Primus is a virtual machine that implements a non-deterministic computational model. Non-determinism here is used in the same meaning in which it is used in the Non-deterministic Turing machine, i.e., it is a machine in which expressions may have more than one values and all these values are considered. Roughly, when a non-deterministic computation happens the Primus machine forks a new instance for each extra value returned by that computation.

Like any other virtual machine, Primus has a set of primitive operations. See the `Primus.Interpreter.Make` functor. These operations closely resemble BIL or BIR, though it is not necessary to use exactly these representations to drive the Primus machine. Any language could be interpreted in terms of these operations. The interpret should just follow the syntactic structure of the interpreted language and map expressions to the operations of the Primus Machine. We have interpreters for two languages, one is BIL (translated into its graphical form called BIR) and the other is called Primus Lisp.

Primus is built from an extensible set of components. The Core components are:

    `Memory` - which provides a storage facility addressable with arbitrary runtime values;
    `Env` - which provides a storage facility that is addressable by constant names, aka register files;
    `Interpreter` - which provides the set of primitive operations;
    `Linker` - which maps program locations to code.

Users may implement their own components, which may affect the behavior of the Primus Machine in rather arbitrary but still limited ways. The main mechanism for altering machine behavior is through subscribing to the observations made by the existing components. For example, when the interpreter evaluates the `2 + 2` expression, it posts several observations, like `going to evaluate "2+2"`, `successfully evaluated "2+2" to "4"`. These observeration points provide a predefined set of extension points, in which other components can inject their own code.

This was a very high-level picture of the generic Primus framework. One of the instantiations of this framework is the `run` plugin, which instantiates a machine an runs it on the provided binary from the specified set of entry points. Thus, the `run` plugin is the driving force behind many other analysis plugins, that are using Primus (which are implemented as components of the Primus machine).

For example, the `promiscuous-mode` plugin drastically changes the behavior of the machine, making some BIL programs into non-deterministic programs. For example, when `if <cnd> then <yes-program> else <no-program>` is seen, the promiscuous component forks a new machine that will follow the else branch, even if <cnd> holds. This component also enables reading from arbitrary locations of memory (even those that are not allocated) by allocating them before they are read and filling them with random contents. It also hushes exceptions, such as division by zero.

Another interesting component, called `limiter`, is responsible for program termination. It just counts the total number of primitive operations made by a machine instance and halts it once the limit is reached.

The taint component (in fact there are several components involved, each doing its job) tracks all values that the machine produces and if they match one of the specified rules (by other components) the it attaches a taint to them. Also, there are components that propagate taints from inputs of primitive operations to their outputs, based on the specified set of propagation rules.

<reached the maximum length, will continue with more details on Lisp and its place>
_
Ivan Gotovchits
@ivg
Nov 05 2019 04:43

Now the Lisp machine, which is just an interpreter of the BAP Lisp language. It is responsible for parsing the Primus Lisp program modules and link them using the Linker component. Primus Lisp functions may declare themselves as functions with external linkage, so that Primus Linker component will call the Lisp code, instead of the code provided by the binary itself. For example, when `malloc` is called the corresponding function defined in Primus Lisp is called instead (if it was loaded). This mechanism is used to write stubs for functionality that is missing in the binary, e.g., libc and other functions defined in the POSIX interface. This enables an analysis of partially specified programs. It could also be used to change the semantics of the binary, as in general a Lisp program (or any other code) could be linked at any address.

The Lisp code can also reflect on Primus observations, which are made available to the Lisp coders through the mechanism of signals and methods. A Primus observation could be reified into the Primus Lisp signal (observations are more general than Primus Lisp signals, i.e., not all observations could be reified into a concrete signal). When an observation is made the corresponding signal is posted by the Primus Lisp machine and it is dispatched to all registered methods of that signal. For example, the `call` observation is reified into the `call` signal, and `(defmethod call (name args..) body)` registers the `call` signal handler so that every time the `call` observation is posted, the method will be invoked with the name of the called function and the list of arguments.

In particular, this is how tainting is implemented. The tainting rules are defined as methods of the `call` and `call-return` signals (to the latter method the value returned by the call is also provided). So, for example, to write a rule that "all values returned by malloc are tainted, we just write

```
(defmethod call-returned (name len ptr)
   (when (and ptr (= name 'malloc))
      (taint-introduce-directly 'mallocated-pointer ptr)))
```

Ivan Gotovchits
@ivg
Apr 04 2019 00:52

The `run` plugin is just a plugin, so you can implement your own runner. Besides, run is not responsible for forks (neither their creation, nor their scheduling or pruning). Therefore, by default it just sets up the machine selects the entry point and just runs.

It is the `primus-promiscuous` plugin which is responsible for all this forks creation. So, ideally, you should create a plugin which will provide the `primus-trace-mode` which will accept a trace (or a set of traces) and will force the execution in the right direction. I would suggest you to look into the promiscuous mode implementation, as in fact, you need something very close, except that the promiscuous mode is forking a machine at every branch, where you instead can just force the only fork. On the high level, the idea is to hook the execution after each last definition in a block, then analyze all destinations, and pick the right one, by changing the guard variable (or destination variable, in case of the unresolved jump).

However, if you would like to implement your own `run` plugin, then you can use the `run` plugin as an example of how you can set up the Primus Machine.
