# Keeping a Forked Repository in Sync with the Original

## Forking the Repository

To start working with a Git repository, you need to fork it to your GitHub account. Here's how to do it:

- Go to the original repository on GitHub.
- Click on the "Fork" button in the top right corner of the repository page.
- Select your GitHub account as the destination for the fork.

## Cloning the Forked Repository

To work with the forked repository on your local machine, you need to clone it. Here's how to do it:

- Open Terminal.app (macOS) or Git Bash (Windows).
- Navigate to the directory where you want to clone the repository by running:

`cd /path/to/your/directory`

- Clone the forked repository by running:

`git clone https://github.com/YOUR-USERNAME/FORKED-REPO.git`

Replace `YOUR-USERNAME` with your GitHub username, and `FORKED-REPO` with the name of your forked repository.

## Adding the Original Repository as a Remote

To keep your forked repository in sync with the original repository, you need to add the original repository as a remote. Here's how to do it:

- Open Terminal.app (macOS) or Git Bash (Windows).
- Navigate to your forked repository directory by running:

`cd /path/to/your/forked/repo`

- Add the original repository as a remote by running:

`git remote add upstream https://github.com/ORIGINAL-USERNAME/ORIGINAL-REPO.git`

Replace `ORIGINAL-USERNAME` with the username of the owner of the original repository, and `ORIGINAL-REPO` with the name of the original repository.

## Fetching Changes from the Original Repository

To keep your forked repository in sync with the original repository, you need to fetch any changes that have been made since your last update. Here's how to do it:

- Open Terminal.app (macOS) or Git Bash (Windows).
- Navigate to your forked repository directory by running:

`cd /path/to/your/forked/repo`

- Fetch the latest changes from the original repository by running:

`git fetch upstream`

1. Check if there are any changes that you need to merge by running:

`git status`

If there are changes to merge, Git will tell you which branch they are on and give you instructions on how to merge them.

## Merging Changes from the Original Repository

Once you have fetched the changes from the original repository, you need to merge them into your local branch. Here's how to do it:

- Open Terminal.app (macOS) or Git Bash (Windows).
- Navigate to your forked repository directory by running:

`cd /path/to/your/forked/repo`

- Merge the changes into your local branch by running:

`git merge upstream/main`

Replace `main` with the name of the branch in the original repository that you want to merge into your local branch.

## Pushing Changes to the Forked Repository

Once you have merged the changes from the original repository into your local branch, you need to push them to your forked repository. Here's how to do it:

- Open Terminal.app (macOS) or Git Bash (Windows).
- Navigate to your forked repository directory by running:

`cd /path/to/your/forked/repo`

- Push the changes to your forked repository by running:

`git push`

That's it! I hope this drill helps you or your students learn how to keep a forked repository in sync with the original repository, add the original repository as a remote, fetch changes, merge changes, and push changes. Let me know if you have any questions or feedback.
