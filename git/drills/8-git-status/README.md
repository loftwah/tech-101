# Using the `git status` Command

The `git status` command is used to display the status of the Git repository. It shows which files are currently being tracked, which files have been modified, and which files are staged for commit. Here's how to use the `git status` command:

## Checking the Status of the Repository

1. Open Terminal.app (macOS) or Git Bash (Windows).
2. Navigate to the directory where the repository is located by running:

`cd /path/to/your/repo`

1. Run the `git status` command to check the status of the repository:

`git status`

## Understanding the Output of `git status`

The output of the `git status` command contains information about the current status of the repository. Here's what each section of the output means:

* On branch `main`: Shows the name of the current branch.
* Your branch is up to date with 'origin/main': Shows that your local branch is up to date with the remote branch.
* Changes not staged for commit: Shows the files that have been modified but have not been staged for commit.
* Untracked files: Shows the files that have been added to the repository but have not been tracked by Git.
* Changes to be committed: Shows the files that have been staged for commit.

## Using `git status` with Options

The `git status` command can be used with options to provide more detailed information about the status of the repository. Here are some useful options:

* `-s` or `--short`: Shows the status of files in a short format.
* `-b` or `--branch`: Shows the current branch and tracking information.
* `-u` or `--untracked-files`: Shows the untracked files in addition to the modified and staged files.

Here's how to use the `git status` command with options:

1. Open Terminal.app (macOS) or Git Bash (Windows).
2. Navigate to the directory where the repository is located by running:

`cd /path/to/your/repo`

1. Run the `git status` command with options to check the status of the repository:

`git status -sb`

That's it! I hope this drill helps you or your team learn how to use the `git status` command to check the status of the repository and understand its output. Let me know if you have any questions or feedback.
