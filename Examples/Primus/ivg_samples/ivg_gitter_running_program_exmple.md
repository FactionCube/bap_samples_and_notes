Here is the full list of signals [Ed: bookmarked in firefox.] that are available in the Lisp Machine (form OCaml there is even more). If you will scroll up you will see all functions and primitives available for lisp programmer. And the language itself is described here,[ but mostly it looks a lot like Common Lisp (emacs lisp, any other lisp), so there shouldn't be any surprises here :)

Okay, so I've found a bug, it looks like that our input channel is stubbing didn't work (only the output).
So this is an example that I was going to use as a demonstration (and now I will also use it as a test case). The input file is a program that reads a file and prints its output, basically, like the cat utility. I've compiled it for ARM,

$ file program
program: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-, for GNU/Linux 3.2.0, BuildID[sha1]=77658dc44afdc9e0b081e84a02d75b10e73209ca, not stripped

so let's use bap to run it


$ bap program --run-argv=program,program.c -prun --primus-lisp-channel-redirect=program.c:program.c
#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <unistd.h>


int main(int argc, const char *argv[]) {
    char buf[BUFSIZ];
    int fd;

    if (argc < 2) {
        puts("Usage: ./program <input>");
        exit(1);
    }

    fd = open(argv[1], O_RDONLY);

    if (fd < 0) {
        puts("Failed to open file");
        exit(1);
    }

    while(1) {
        int i;
        int len = read(fd, buf, BUFSIZ);
        if (len == 0) {
            exit(0);
        } else if (len < 1) {
            puts("IO error");
            exit(3);
        } else {
            for (i = 0; i < len; i++)
                putchar(buf[i]);
        }
    }
}

beyond specifying obvious options, such as command-line arguments to the program that is being run, we also set channel redirections. Primus (of course) will not access any files on your real system during emulation (otherwise it will be very unsafe to use it). But it is possible to map emulated paths into real paths. In our case, we just map program.c to program.c.

When the program is run it outputs the contents of the file, the same if you will run it on a real cpu. Now, let's hack it using the following lisp program (and using bap instead of cat):


$ bap program --run-argv=program,program.c -prun --primus-lisp-channel-redirect=program.c:test.lisp
(require posix)

(defmethod call-return (name _ buf len _)
  (when (and (= name 'read) (> len 0))
   (memset buf ?a len)))

Notice, that I just changed the redirections to test.lisp and now we output the test.lisp file :)

So the lisp code will intercept all calls to read and fill them with 'a', let's try it:

$ bap program --run-argv=program,program.c -prun --primus-lisp-channel-redirect=program.c:program.c --primus-lisp-load=test
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

That's all folks :)

fyi, notation ?x is the same as 'x' in C or OCaml :) 
