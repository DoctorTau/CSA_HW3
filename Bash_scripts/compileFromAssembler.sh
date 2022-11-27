#!/bin/bash

# Get the first argument of the script if it exists
if [ -z "$1" ]
then
    Assembler_files="./Assembler_files"
else
    Assembler_files="$1"
fi

for file in ./Assembler_files/*.s
do
    filename=$(basename "$file")
    filename="${filename%.*}"

    gcc ./Assembler_files/$filename.s -c -o ./Object_files/$filename.o
done

gcc ./Object_files/*.o -o ./Executable_files/program -lm