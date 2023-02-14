# Git Workflow

The Git workflow is a set of best practices for using Git in a team environment. It involves a series of steps that help ensure that the codebase is well-maintained and consistent, and that developers can work together effectively.

## Setting Up the Repository

To start working with Git, you need to set up a repository. Here's how to do it:

1. Create a new repository on GitHub.
2. Clone the repository to your local machine by running:

`git clone https://github.com/USERNAME/REPO.git`

Replace `USERNAME` with your GitHub username, and `REPO` with the name of your repository. 3. Navigate to the repository directory by running:

`cd /path/to/your/repo`

## Creating a New Branch

When you start working on a new feature or bug fix, you should create a new branch. Here's how to do it:

- Make sure you are on the main branch by running:

`git checkout main`

- Create a new branch for your feature or bug fix by running:

`git checkout -b my-feature`

Replace `my-feature` with the name of your new branch. 3. Make your changes to the code, add and commit them by running:

```bash
git add .
git commit -m "Added feature X"
```

## Merging the Branch

Once you have finished working on your feature or bug fix, you should merge the branch back into the main branch. Here's how to do it:

- Make sure you are on the main branch by running:

`git checkout main`

- Merge your feature or bug fix branch into the main branch by running:

`git merge my-feature`

Replace `my-feature` with the name of your branch. 3. Push your changes to the remote repository by running:

`git push`

## Reviewing Code

Before merging your changes into the main branch, you should have your code reviewed by another developer. Here's how to do it:

- Push your feature or bug fix branch to the remote repository by running:

`git push -u origin my-feature`

1. Open a pull request on GitHub and ask for feedback and review from your team.
2. Address any comments or feedback and push new commits to the branch.
3. Once the code has been reviewed and approved, merge the pull request into the main branch by following these steps:
    1. Go to your pull request on GitHub and click on the "Merge pull request" button.
    2. Choose the merge method (e.g., merge commit or squash and merge).
    3. Add a title and description for your merge commit.
    4. Click on the "Confirm merge" button to merge the pull request.

## Updating the Repository

To keep your local repository in sync with the remote repository, you need to pull changes from the remote repository. Here's how to do it:

- Fetch the latest changes from the remote repository by running:

`git fetch`

- Merge the changes into your local branch by running:

`git merge origin/main`

That's it! I hope this drill helps you or your team learn how to use Git in a team environment, create a new branch, merge a branch, review code, and keep the repository up to date. Let me know if you have any questions or feedback.
