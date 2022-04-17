# merge-and-ignore

A small addition for `git merge` to ignore incoming changes to certain local-files when merging.

## Installation

Run the following command:
```
git config alias.merge-and-ignore '!sh ./merge-and-ignore.sh "${args[@]}"'
```

## How To Use

You can now `git merge` and ignore incoming changes for files you wish to preserver theirs state, you can do this for as many files as you want:

For example:
```
git checkout master
git merge-and-ignore <FEATURE-BRANCH-NAME> <FILE-1> <FILE-2> <FILE-3>
```

## Why Use `git merge-and-ignore`

This feature can be useful for example when you want to preserve your configuration files during `git merge`, such as:

- `Web.config`
- `App.config`
- `appsettings.json`
