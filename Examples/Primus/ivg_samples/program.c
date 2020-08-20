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

