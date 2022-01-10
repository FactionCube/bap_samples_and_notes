Ivan Gotovchits
@ivg
Nov 23 2021 08:12

You can use `--primus-lisp-channel-redirection` to map emulated file paths to real file paths, e.g.,

`bap ./exe --run --primus-lisp-channel-redirect=/etc/passwd:./mypass.txt`

and every time `/etc/passwd` is opened it will be fed with the contents of `./mypass.txt`


But for a more general case, and if you don't only want to spuff IO channels that are accessed via open/fopen, then you need to write Primus Lisp stubs for the functions that you want to spuff, e.g.,

```
;; file myspuffer.lisp
(require posix)
(defconstant +my-input+ "data.hex")

(defun my-spuffer (_fd buf len)
  (declare (external "socket_read"))
  (let ((ch (channel-open +my-input+)))
    (read ch buf len)
    (channel-close ch)))
```

Here is the Primus Lisp Primer, and to load your lisp file, specify the basename of the file in the set of features that you would like to load, e.g.,

`bap ./exe --run --primus-lisp-load=myspuffer`
