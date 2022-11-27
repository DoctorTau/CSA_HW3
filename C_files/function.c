#include <math.h>
#include <stdio.h>

double factorial(double x) {
    if (x == 0) {
        return 1;
    } else {
        return x * factorial(x - 1);
    }
}

void function(double *x) {
    int i;
    double result = 0;
    for (i = 0; i <= 100; i++) {
        result += pow(*x, i) / factorial(i);
    }
    *x = 1 / result;
}
