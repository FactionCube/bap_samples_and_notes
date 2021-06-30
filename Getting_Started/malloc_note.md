@ivg June 2021 (Gitter):

See also https://binaryanalysisplatform.github.io/bap/api/lisp/

Of course, you have the full control over anything in Primus. The `memory-write` primitive is the 
lowest-level option that takes an address and a byte. You can also use the `write-word` macro that 
lets you write words (and which abides to the endianness laws). And, of course, you're free to 
use high-level posix interfaces (which is actually recommended) like `malloc`, `memset`, `memcpy`, and 
so on. Besides, if you want to get the up-to-date Primus Lisp documentation use 
`bap primus-lisp-documentation > primus.org` it will generate the `primus.org` file (which is a 
simple text file in the org-mode, something like markup). You can even ask emacs to turn it into html.


