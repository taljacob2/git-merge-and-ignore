#!/bin/sh

ARGS=("$@")
NUMBER_OF_ARGS=${#ARGS[@]}
MINIMUM_NUMBER_OF_ARGS=1
if [ "$#" -lt $MINIMUM_NUMBER_OF_ARGS ]; then
    echo "Wrong number of arguments. Should be at least $MINIMUM_NUMBER_OF_ARGS, but was $NUMBER_OF_ARGS.";
    exit 1;
fi

# FEATURE_RBANCH=${ARGS[0]}
ARRAY_OF_FILES=("${ARGS[@]:1:$NUMBER_OF_ARGS}")

# ---------------------------------- Code -------------------------------------

# echo debug: FEATURE_RBANCH is $FEATURE_RBANCH

git merge ${ARGS[0]} --no-commit --no-ff

for file in "${ARRAY_OF_FILES[@]}";
    do
        echo debug: filename is $file
        git reset HEAD $file   # Unstaging "array of files"
        git checkout -- $file  # Reverting working-directory of "array of files"
    done

git merge --continue

exit