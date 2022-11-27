#include <stdlib.h>
#include <stdio.h>

void WriteToFile(double* to_write, char* filename) {
    FILE* file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error opening file");
        exit(1);
    }
    fprintf(file, "%.10lf", *to_write);
    fclose(file);
}