// file input.c
// gcc -g input.c -o input
// This is Ivan Gotovchit's example code from the BAP Gitter site.  
// See Ivan's discussion in a parent folder in file: primus_taint.md.
#include <stdio.h>

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


