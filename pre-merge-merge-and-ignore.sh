#!/bin/sh

readfile(){
    lineList=()
    while IFS= read -r line || [[ -n "$line" ]]; do
        lineList+=("$line")
    done < "$1"
    echo "${lineList[@]}"
}

echo ($(readfile .gitmergeandignore))