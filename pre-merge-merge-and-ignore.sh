#!/bin/bash

: '
Description:
Reads a file line-by-line to and returns it as an array of strings.

Parameters:
$1: FILE_NAME_TO_READ: Path of the file to read.

Example Of Use:
```
file=$(readFile FILE_NAME_TO_READ)
for line in $file; do
    echo $line
done
```
'
readFile(){
    local lineList=()
    while IFS= read -r line || [[ -n "$line" ]]; do
        lineList+=("$line")
    done < "$1"
    echo "${lineList[@]}"
}

file=$(readFile .gitmergeandignore)
for e in $file; do
    echo $e
done