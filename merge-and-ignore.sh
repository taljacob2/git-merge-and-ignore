#!/bin/sh

source ./functions.sh

# --------------------------------- Setup -------------------------------------

# Assert the given amount of `ARGS` is legal.
ARGS=("$@")
NUMBER_OF_ARGS=${#ARGS[@]}
MINIMUM_NUMBER_OF_ARGS=1
if [ $NUMBER_OF_ARGS -lt $MINIMUM_NUMBER_OF_ARGS ]; then
    echo "Wrong number of arguments. Should be at least $MINIMUM_NUMBER_OF_ARGS, but was $NUMBER_OF_ARGS.";
    exit 1;    
fi

# Check for `--no-read` inline parameter
delete=--no-read
echo DEBUG: DELETING: ${array[@]/$delete}  # Debug.
ARGS=( "${ARGS[@]/$delete}" )  # Quotes when working with strings.
NUMBER_OF_ARGS=${#ARGS[@]}

# Extract wildcards from `MERGE_AND_IGNORE_FILE_NAME_TO_READ`.
MERGE_AND_IGNORE_FILE_NAME_TO_READ=.gitmergeandignore.sh
WILDCARDS_TO_IGNORE_FROM_FILE=()
if [ -e $MERGE_AND_IGNORE_FILE_NAME_TO_READ ]; then
    WILDCARDS_TO_IGNORE_FROM_FILE=$(readFile $MERGE_AND_IGNORE_FILE_NAME_TO_READ)
fi

# Extract wildcards from `ARGS`.
WILDCARDS_TO_IGNORE_FROM_ARGS=("${ARGS[@]:1:$NUMBER_OF_ARGS}")

# Combine both wildcard arrays to a single array.
ALL_WILDCARDS_TO_IGNORE=(${WILDCARDS_TO_IGNORE_FROM_FILE[@]} ${WILDCARDS_TO_IGNORE_FROM_ARGS[@]})

# ---------------------------------- Code -------------------------------------

LOG_TITLE="### merge-and-ignore.sh ###: "
LOG_HALF_BOUNDARY_SHORT="###########################"
LOG_HALF_BOUNDARY="#$LOG_HALF_BOUNDARY_SHORT"

echo $LOG_HALF_BOUNDARY_SHORT START MERGE-AND-IGNORE $LOG_HALF_BOUNDARY

git merge ${ARGS[0]} --no-ff --no-commit > /dev/null 2>&1

for wildcardToIgnore in $ALL_WILDCARDS_TO_IGNORE; do
    echo Ignoring \"$wildcardToIgnore\"  # Output logs.

    git reset HEAD $wildcardToIgnore > /dev/null 2>&1   # Unstaging the current wildcard.
    git checkout -- $wildcardToIgnore > /dev/null 2>&1  # Reverting working-directory of the current wildcard.
done

echo $LOG_HALF_BOUNDARY_SHORT FINISH MERGE-AND-IGNORE $LOG_HALF_BOUNDARY_SHORT

# DEVELOPER NOTE: Choose one of the following options:
GIT_EDITOR=true git merge --continue  # DEVELOPER NOTE: Enable this line to enable `--no-edit`.
# git merge --continue  # DEVELOPER NOTE: Enable this line to disable `--no-edit`.

exit