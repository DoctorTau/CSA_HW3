#include <stdlib.h>
#include <stdio.h>

void generateRandomDouble(double *x) {
    *x = (double)rand() / (double)RAND_MAX;
}