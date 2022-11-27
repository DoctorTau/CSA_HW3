#include <stdlib.h>
#include <time.h>
#include <stdio.h>

int MAX_SIZE = 1000000;

extern void ReadFromFile(char* filename, double* to_write);
extern void WriteToFile(double* to_write, char* filename);
extern void function(double* x);
extern void generateRandomDouble(double* x);

int main(int argc, char* argv[]) {
    srand(time(NULL));
    clock_t timer;
    double x;
    char *input_file, *output_file;
    if (argc == 1) {
        printf("No output file specified. Using default output file: output.txt\n");
        printf("No input file specified. Generating random input.\n");
        generateRandomDouble(&x);
        output_file = "output.txt";
    } else if (argc == 2) {
        printf("No input file specified. Generating random input.\n");
        generateRandomDouble(&x);
        output_file = argv[1];
    } else {
        input_file = argv[1];
        ReadFromFile(input_file, &x);
        output_file = argv[2];
    }

    timer = clock();
    function(&x);
    timer = clock() - timer;

    WriteToFile(&x, output_file);
    long int time_taken = ((long int)timer) * 1000000 / CLOCKS_PER_SEC;
    printf("\nProgram took %ld miliseconds to execute \n", time_taken);
    return 0;
}