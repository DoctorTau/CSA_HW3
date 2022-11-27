#!/bin/bash

for file in ./C_files/*.c
do
    filename=$(basename "$file")
    filename="${filename%.*}"

    gcc -masm=intel ./C_files/$filename.c -S -o ./Assembler_files/$filename.s
done

for file in ./Assembler_files/*.s
do
    filename=$(basename "$file")
    filename="${filename%.*}"

    gcc ./Assembler_files/$filename.s -c -o ./Object_files/$filename.o
done

gcc ./Object_files/*.o -o ./Executable_files/program