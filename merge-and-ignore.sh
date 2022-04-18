#!/bin/sh

ARGS=("$@")
NUMBER_OF_ARGS=${#ARGS[@]}
MINIMUM_NUMBER_OF_ARGS=1
if [ "$#" -lt $MINIMUM_NUMBER_OF_ARGS ]; then
    echo "Wrong number of arguments. Should be at least $MINIMUM_NUMBER_OF_ARGS, but was $NUMBER_OF_ARGS.";
    exit 1;
fi

ARRAY_OF_FILES=("${ARGS[@]:1:$NUMBER_OF_ARGS}")

# ---------------------------------- Code -------------------------------------

git merge ${ARGS[0]} --no-ff --no-commit

for file in "${ARRAY_OF_FILES[@]}";
    do
        git reset HEAD $file > /dev/null 2>&1   # Unstaging "array of files"
        git checkout -- $file > /dev/null 2>&1  # Reverting working-directory of "array of files"
    done

git merge --continue

exit