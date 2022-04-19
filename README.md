> v2.0.0

# git-merge-and-ignore

A small addition for `git merge` to "ignore" *incoming changes* to certain ***local*** files / folders when merging, in the case where the remote version and the local version of these files **do not conflict** and you still want to "ignore" the *incoming changes* from the remote to those files.

Keep in mind that "git-merge-and-ignore" is **different** than `.gitattributes`, because the latter only gets triggered when there are *conflicts* while merging, so the `merge=ours` or `merge=keepMine` strategies unfortunately **do not** help you "ignoring" incoming changes for files when it happen that you **do not have *conflicts* when merging** them.

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

- You can now `git merge` and ignore incoming changes for files / folders you wish to preserve theirs state, you can do this for as many files as you want.
- "git-merge-and-ignore" accepts all *git wildcards*.

Choose one of the following options:

- ### Via A Pre-Made `.gitmergeandignore.sh` File

    Create a file named `.gitmergeandignore.sh` in your project's **root folder**, and state there line-by-line your *wildcards* to ignore. (Same as [`.gitignore`](https://git-scm.com/docs/gitignore)).
    "git-merge-and-ignore" will read the *wildcards* you have stated there.

    After you have configured `.gitmergeandignore.sh`, you can run for example:
    ```
    git checkout master
    git merge-and-ignore <FEATURE-BRANCH-NAME>
    ```

    > **ADVANCED SETTINGS:**
    >
    > You are able to customise the name of `.gitmergeandignore.sh` by changing the value of `MERGE_AND_IGNORE_FILE_NAME_TO_READ` to your desired file name, in [merge-and-ignore.sh](merge-and-ignore.sh).

- ### Via An Inline-Command

    For example:
    ```
    git checkout master
    git merge-and-ignore <FEATURE-BRANCH-NAME> <WILDCARD-1> <WILDCARD-2>
    ```

    #### NOTE

    By default, "git-merge-and-ignore" always looks for the `.gitmergeandignore.sh` file to read from.
    So the final result will be a combination of both the *wildcards* stated in `.gitmergeandignore.sh` **and** in the *inline-command*.

    You can disable "git-merge-and-ignore" from reading the *wildcards* stated in `.gitmergeandignore.sh`, for a *single inline-command* by stating the `--no-read` inline parameter.
    For example:
    ```
    git checkout master
    git merge-and-ignore --no-read <FEATURE-BRANCH-NAME> <WILDCARD-1> <WILDCARD-2>
    ```

## Check For Updates

In case you already have an existing version of "git-merge-and-ignore" and you want to update to the newest version available,
you can merge the newest version of this repository to your existing `git-merge-and-ignore` folder:
```
git subtree pull -P git-merge-and-ignore https://github.com/taljacob2/git-merge-and-ignore master --squash
```
