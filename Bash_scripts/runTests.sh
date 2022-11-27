#!/bin/bash

for file in ./Test/Test_in/*.in
do
    filename=$(basename "$file")
    filename="${filename%.*}"

    ./Executable_files/program ./Test/Test_in/$filename.in ./Test/Test_out/$filename.out
done

