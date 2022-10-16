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
        [ "${line:0:1}" = "#" ] && continue  # Skip all lines that begin with '#'
        lineList+=("$line")
    done < "$1"
    echo "${lineList[@]}"
}

: '
Description:
Resolves a conflicted file with a certain strategy: ours|theirs|union

Parameters:
$1: STRATEGY: Pick a strategy between `ours|theirs|union` to resolve the file
              with.
$2: FILE_PATH: The path to the conflicted file to resolve.
'
resolveConflictedFile() {
  STRATEGY="$1"
  FILE_PATH="$2"

  git show :1:"$FILE_PATH" > ./tmp.base
  git show :2:"$FILE_PATH" > ./tmp.ours
  git show :3:"$FILE_PATH" > ./tmp.theirs

  git merge-file "$STRATEGY" -p ./tmp.ours ./tmp.base ./tmp.theirs > "$FILE_PATH"
  git add "$FILE_PATH"

  rm ./tmp.base
  rm ./tmp.ours
  rm ./tmp.theirs
}
