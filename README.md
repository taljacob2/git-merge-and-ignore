> V1.0.1

# git-merge-and-ignore

A small addition for `git merge` to ignore *incoming changes* to certain ***local*** files / folders when merging.

> NOTE: `git merge-and-ignore` accepts *git wildcards*.

## Why Use `git merge-and-ignore`

This feature can be useful when you want to preserve the current state of some important files / folders during a `git merge` and make sure they won't be changed, such as:

**For example:**

Configuration files:
- `Web.config`
- `App.config`
- `appsettings.json`

## Installation

### Clone This Repository As A Subtree In Your Project

Merge this repository to a new folder called `git-merge-and-ignore` at the root folder of your project:
```
git subtree add -P git-merge-and-ignore https://github.com/taljacob2/git-merge-and-ignore master --squash
```

### Configure The Alias Of `git merge-and-ignore`

Run the following command:
```
git config alias.merge-and-ignore '!sh ./git-merge-and-ignore/merge-and-ignore.sh "${args[@]}"'
```

## How To Use

You can now `git merge` and ignore incoming changes for files / folders you wish to preserve theirs state, you can do this for as many files as you want:

For example:
```
git checkout master
git merge-and-ignore <FEATURE-BRANCH-NAME> <FILE-1> <FILE-2> <FOLDER-1> <FOLDER-2> <WILDCARD-1> <WILDCARD-2>
```

## Check For Updates

In case you already have an existing version of "git-merge-and-ignore" and you want to update to the newest version available,
you can merge the newest version of this repository to your existing `git-merge-and-ignore` folder:
```
git subtree pull -P git-merge-and-ignore https://github.com/taljacob2/git-merge-and-ignore master --squash
```
