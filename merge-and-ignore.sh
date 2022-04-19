#!/bin/sh

source functions.sh

# --------------------------------- Setup -------------------------------------

# Assert the given amount of `ARGS` is legal.
ARGS=("$@")
NUMBER_OF_ARGS=${#ARGS[@]}
MINIMUM_NUMBER_OF_ARGS=1
if [ $NUMBER_OF_ARGS -lt $MINIMUM_NUMBER_OF_ARGS ]; then
    echo "Wrong number of arguments. Should be at least $MINIMUM_NUMBER_OF_ARGS, but was $NUMBER_OF_ARGS.";
    exit 1;    
fi

# Extract wildcards from `MERGE_AND_IGNORE_FILE_NAME_TO_READ`
MERGE_AND_IGNORE_FILE_NAME_TO_READ=.gitmergeandignore.sh
WILDCARDS_TO_IGNORE_FROM_FILE=()
if [ -e $MERGE_AND_IGNORE_FILE_NAME_TO_READ ]; then
    WILDCARDS_TO_IGNORE_FROM_FILE=$(readFile $MERGE_AND_IGNORE_FILE_NAME_TO_READ)
fi

# Extract wildcards from `ARGS`
WILDCARDS_TO_IGNORE_FROM_ARGS=("${ARGS[@]:1:$NUMBER_OF_ARGS}")

# Combine both wildcard arrays to a single array.
ALL_WILDCARDS_TO_IGNORE=(${WILDCARDS_TO_IGNORE_FROM_FILE[@]} ${WILDCARDS_TO_IGNORE_FROM_ARGS[@]})

# ---------------------------------- Code -------------------------------------

git merge ${ARGS[0]} --no-ff --no-commit

for wildcardToIgnore in $ALL_WILDCARDS_TO_IGNORE; do
    echo DEBUG: $wildcardToIgnore  # TODO: Remove debug.
    git reset HEAD $wildcardToIgnore > /dev/null 2>&1   # Unstaging "array of files"
    git checkout -- $wildcardToIgnore > /dev/null 2>&1  # Reverting working-directory of "array of files"
done

git merge --continue

exit