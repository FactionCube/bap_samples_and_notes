QUESTION:
Hi there! Totally new to BAP and in need of some pointers: I have two use cases for which I think BAP could help me. For starters, I'd like to implement taint inference by checking whether a tainted value changes the value of the condition in a branch statement (this is from a recent paper "GreyOne: Data Flow Sensitive Fuzzing"). How can I execute my target with a specified input and get the value of a register or a memory location when the instruction pointer hits a certain address?




REPLY:
    For starters, I'd like to implement taint inference by checking whether a tainted value changes the value of the condition in a branch statement 

We already have this analysis on board :) So let me describe it real quick, and then we can go into low-level details. The analysis is a little bit more general, though we call it information flow analysis. The idea is that you specify a set of sources that are untrusted (i.e., they introduce taint into the system). This is an example specification that defines a few user inputs that we, in general, do not trust. And this is an example of sensitive sinks which should be tainted by those inputs. Of course, for each taint there could be a sanitization. Some times it is some canonicalization or escaping function, sometimes just having a branching with a condition that depends on the tainted input could be considered as a sanitization procedure. For example, we have the following rule:

(defmethod eval-cond (c)
  (let ((t (taint-get-direct 'untrusted c)))
    (when t
      (dict-add 'untrusted/checked t (incident-location)))))

that says, that every time we see a conditional jump with the condition c so that c is tainted by a taint that is designated as 'untrusted we mark it with untrusted/checked and record this branch as the check location. (To get more information on how we represent locations scroll a couple of messages above).

So, I think this is what you're looking for. Now let's open the hood and look inside. The framework that drives this analysis is called Primus and it is a non-deterministic interpreter that could go into the promiscuous mode (a mode of execution that bears sings of microexecution and forced execution). In other words, we take a binary, lift it into IR and then execute taking all linearly independent paths in that binary. The Primus Interpreter posts observations every time it does something, there are a few of them. Those observations are usually stored in a file called incidents but this no more than a convention. Mostly, because our incident analysis framework is also using the mechanism of observations and out of those tons of observations made during program execution, we are mostly interested in any discovered incidents. For quick specification of security policies and taint policies and other for many other purposes we use a DSL called Primus Lisp. In Primus Lisp we can programmatically process observations without having a need to write any OCaml code and do any compilation. E.g., suppose we would like to solve your task from scratch. The observation that you need is called eval-cond and suppose we want to taint all the data that we read(2). First let's write the rule that will introduce the taint:

(defmethod call-return (name fd ptr _ len)
  (when (and (= name 'read) (> len 0))
    (taint-introduce-indirectly 'bad-read ptr len)))

We subscribed to the call-return observation, and every time the read call returns we take the pointer to the buffer and taint the number of bytes that we read, if any. Now the taint propagation engine will automatically propagate this taint throughout the program state (using the default taint propagation policy, but you can specify your own). Now, let's capture all branches that depend on this taint (and depend on the input read with read)

(defmethod eval-cond (c)
  (when (taint-get-direct 'bad-read c)
    (incident-report 'bad-read-controlled-branch
                     (incident-location))))

We've subsrcibed to the eval-cond and if the branch condition bears signs of the 'bad-read taint, then we report an incident that we arbitrarily named bad-read-controlled-branch and pass our current location to it.
We will, then can go and look into the incidents file (provided you name it incidents) and collect all the (incident 'bad-read-controlled-branch ...) lines from it.
Now, the main question is how to run all this stuff. In BAP we have lots of controls and options and choosing the right set of parameters is sometimes not an easy tasks. That's why we have recipes - which is basically a set of command-line options together with some specifications and input files, that you can share and reuse. A good starting point is our collection of ready to go analysis and recipes. Ideally, you should be able to pick an analysis that is closest to what you need and then copy and modify it to your needs. In your case, it should be primus checks. This recipe runs all checks in parallel, so it is probably doing more than needed, but you can easily strip away the unnecessary functionality if you want. Once you install it (using common make && make install in the root folder, make sure that you have bap installed also), you should be seeing a lot of recipes available to you, e.g.,

bap list recipes
  av-rule-3                all functions shall have a cyclomatic complexity number of 5...
  jpl-rule-4               there shall be no direct or indirect use of recursive functi...
  av-rule-22               the input/output library <stdio.h> shall not be used
  mc-test                  description was not provided
  av-rule-174              the null pointer shall not be de-referenced
  av-rule-25               the time handling functions of library <time.h> shall not be...
  forbidden-symbol         runs all the analysis that check the program for a presence ...
  untrusted-argument       detects a usage of untrusted data by some certain functions
  defective-symbol         runs all the analysis that checks static properties of subro...
  must-check-value         detects that a return value of certain functions is unchecke...
  av-rule-189              the goto statement shall not be used
  double-free              detects a double call to 'free' on the same memory address
  jpl-rule-11              detects symbols with non-structural cfg
  jpl-rule-14              detects unused values returned by functions
  av-rule-21               the signal handling facilities of <signal.h> shall not be us...
  heap-overflow            description was not provided
  primus-checks            runs a variety of security checks using Primus
  av-rule-23               the library functions atof, atoi and atol from library <stdl...
  av-rule-19               <locale.h> and the setlocale function shall not be used
  use-after-free           detects access to a memory that has been freed previously
  restrictness-check       detects an aliasing of functions arguments with 'restrict' t...
  av-rule-20               the setjmp macro and the longjmp function shall not be used
  warn-unused              detects an unused result of a function with warn-unused-resu...
  av-rule-24               the library functions abort, exit, getenv and system from li...
  av-rule-17               the error indicator errno shall not be used.

we can get an idea of what a recipe is doing by either going into the corresponding folder and reading its contents or by using the print-recipe command, e.g.,

DESCRIPTION

runs a variety of security checks using Primus

<snip lots of text>

COMMAND LINE

--optimization-level=0 \
--primus-print-obs=exception,pc-changed,jumping,call,call-return,machine-switch,machine-fork,lisp-message,incident,incident-location \
--primus-limit-max-length=4096 \
--primus-print-output=incidents \
--primus-greedy-scheduler \
--primus-promiscuous-mode \
--constant-tracker-enable \
--run-entry-points=all-subroutines \
--log-dir=log \
--report-progress \
--primus-lisp-channel-redirect=<stdin>:/tmp/recipe-6df7d426-738f-4768-ab8c-eb866e6e870f.unzipped/stdin,<stdout>:/tmp/recipe-6df7d426-738f-4768-ab8c-eb866e6e870f.unzipped/stdout \
--passes=with-no-return,run \
--primus-lisp-add=/tmp/recipe-6df7d426-738f-4768-ab8c-eb866e6e870f.unzipped \
--primus-lisp-load=posix,memcheck-malloc,limit-malloc,taint-sources,sensitive-sinks,warn-unused,check-hardcoded-values

The COMMAND LINE section of the description shows you the actual command line that will be used when you select this recipe. It's quite a lot :)
The most interesting are:

    --passes=run - enables the run pass, which will run the program using Primus;
    --primus-print-output=incidents - designates the name of the file where all observations are stored;
    --primus-greedy-scheduler together with --primus-promiscuous-mode enables forced execution;
    --primus-lisp-load=posix,memcheck-malloc,limit-malloc,taint-sources,sensitive-sinks,warn-unused,check-hardcoded-values - designates the set of Primus Lisp files to load. This is the most important thing for you as you can add or remove files here. For example, you can put the code examples above in a file named track-read.lisp and then do --primus-lisp-load=posix,track-read and then only your analysis will run. (We need to include the posix feature since we want to track the read(2) call).

I hope this helps, feel free to ask questions :)
