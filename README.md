# git-merge-and-ignore

A small addition for `git merge` to ignore incoming changes to certain local-files when merging.

## Installation

### Clone This Repository As A Subtree In Your Project

Merge this repository to a folder called `git-merge-and-ignore` at the root folder of your project:
```
git checkout master
git remote add -f git-merge-and-ignore https://github.com/taljacob2/git-merge-and-ignore
git subtree add -P git-merge-and-ignore git-merge-and-ignore/master --squash
git remote remove git-merge-and-ignore
```

### Configure The Alias Of `git merge-and-ignore`

Run the following command:
```
git config alias.merge-and-ignore '!sh ./git-merge-and-ignore/merge-and-ignore.sh "${args[@]}"'
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
