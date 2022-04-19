#!/bin/bash

source functions.sh

# ---------------------------------- Code -------------------------------------

FILE_NAME_TO_READ=.gitmergeandignore.sh
if [ -e $FILE_NAME_TO_READ ]; then
    file=$(readFile $FILE_NAME_TO_READ)
    for line in $file; do
        echo $line
    done
fi