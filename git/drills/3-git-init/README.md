# Git Init: Creating a New Git Repository

This drill will teach you how to create a new Git repository, add and commit changes, view the commit history, and ignore files.

## Initializing a Git Repository

To start using Git for version control, you need to create a new Git repository. Here's how to do it:

1. Open Terminal.app (macOS) or Git Bash (Windows).
2. Navigate to the directory where you want to create your new repository by running:

`cd /path/to/your/directory`

1. Initialize a new Git repository in that directory by running:

`git init`

## Adding and Committing Changes

Once you have initialized a new Git repository, you can start adding and committing changes to it. Here's how to do it:

1. Create a new file in your repository directory by running:

`touch myfile.txt`

1. Open the file in your favorite text editor and add some text to it.
2. Add the file to your Git repository by running:

`git add myfile.txt`

1. Commit the changes to your Git repository by running:

`git commit -m "Added myfile.txt"`

## Viewing Commit History

Git keeps a log of all the changes you make to your repository, along with information about who made the change and when. Here's how to view the commit history of your repository:

1. Open Terminal.app (macOS) or Git Bash (Windows).
2. Navigate to your repository directory by running:

`cd /path/to/your/directory`

1. View the commit history of your repository by running:

`git log`

1. To quit the log view, press `q`.

## Ignoring Files

Sometimes, you may have files in your repository that you don't want to track with Git, such as build artifacts, log files, or user-specific configuration files. To tell Git to ignore these files, you can create a special file called `.gitignore`. Here's how to create a `.gitignore` file:

1. Create a new file in your repository directory called `.gitignore` by running:

`touch .gitignore`

1. Open the file in your favorite text editor and add a list of file patterns that you want to ignore, one pattern per line. For example, to ignore all files with the extension `.log` and the directory `build`, you would add:

```bash
*.log
build/
```

1. Add the `.gitignore` file to your Git repository by running:

`git add .gitignore`

1. Commit the changes to your Git repository by running:

`git commit -m "Added .gitignore file"`

That's it! I hope this drill helps you or your team learn how to create a new Git repository, add and commit changes, view the commit history, and ignore files. Let me know if you have any questions or feedback.
