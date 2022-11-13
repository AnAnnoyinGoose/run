#!/bin/bash

# This script takes a single argument (filename w/ its path)
# it will get the file type (cpp,c,py,nim etc.)
# and run/compile it
# usage: .$PATH/run ( or alias in .zshrc or .shrc) $PATH/someapp.someext

# if no argument is passed, print usage
# and exit
if [ $# -eq 0 ]
then
    echo "Usage: run <path/to/file>"
    exit 1
fi

# get the file type
#

filetype=$(echo $1 | cut -d'.' -f2)

# get the file name
filename=$(echo $1 | cut -d'.' -f1)

# get the file name without the path
filename=$(echo $filename | rev | cut -d'/' -f1 | rev)

# get the file path
filepath=$(echo $1 | rev | cut -d'/' -f2- | rev)

# if the file is a cpp file
# compile it and run it
if [[ $filetype = "cpp" ]]; then
    g++ $1 -o $filepath/$filename
    $filepath/$filename
fi

# if the file is a c file
# compile it and run it
if [[ $filetype == "c" ]]; then
    gcc $1 -o $filepath/$filename
    $filepath/$filename
fi

# if the file is a python file
# run it
if [[ $filetype == "py" ]]; then
    python3 $1
fi

# if the file is a nim file
# compile it and run it
if [[ $filetype == "nim" ]]; then
    nim c -r $1
fi

# if the file is a java file
# compile it and run it
# NOTE: this will not work if the file is in a package
if [[ $filetype == "java" ]]; then
    javac $1
    java $filename
fi

# if the file is a go file
# compile it and run it
# NOTE: this will not work if the file is in a package
if [[ $filetype == "go" ]]; then
    go build $1
    ./$filename
fi

# if the file is a rust file
# compile it and run it
if [[ $filetype == "rs" ]]; then
    rustc $1
    ./$filename
fi

# if the file is a bash file
# run it
if [[ $filetype == "sh" ]]; then
    bash $1
fi


