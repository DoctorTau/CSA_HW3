#include <stdlib.h>
#include <stdio.h>

void ReadFromFile(char* filename, double* to_write) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file");
        exit(1);
    }
    fscanf(file, "%lf", to_write);
    fclose(file);
}