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

# 2nd argumnet are flags to pass to the compiler
# if no flags are passed, use -Wall -Wextra -Werror
if [ $# -eq 1 ]
then
    flags="-Wall -Wextra -Werror"
else
    flags=$2
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

#
# compile and run the file based on its type
# if the file type is not supported, print error
# and exit

if [ $filetype = "cpp" ]
then
    g++ $1 -o $filepath/$filename $flags
    $filepath/$filename
elif [ $filetype = "c" ]
then
    gcc $1 -o $filepath/$filename $flags
    $filepath/$filename
elif [ $filetype = "py" ]
then
    python3 $1
elif [ $filetype = "nim" ]
then
    nim c -r $1
else
    echo "File type not supported"
    exit 1
fi
