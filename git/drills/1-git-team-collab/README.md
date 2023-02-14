# Using Git and GitHub for Team Collaboration

## Setting Up a Team Repository

1. Create a new repository on GitHub by following these steps:
    1. Log in to your GitHub account and click on the "+" button in the top-right corner.
    2. Click on "New repository" in the dropdown menu.
    3. Choose a name for your repository, and optionally add a description, license, and README file.
    4. Choose whether to make your repository public or private (private repositories require a paid GitHub account).
    5. Click on "Create repository".
2. Invite your team members to collaborate on the repository by following these steps:
    1. Open your repository on GitHub and click on the "Settings" tab.
    2. Click on "Manage access" in the left sidebar.
    3. Click on the "Invite a collaborator" button in the top-right corner.
    4. Enter the GitHub usernames or email addresses of your team members, and choose their role (e.g., read, write, or admin).
    5. Click on "Add" to send the invitations.
3. Set up your local repository by running:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
```

## Working with Branches

1. Create a new branch for your feature or bug fix by running:

`git checkout -b my-feature`

1. Make your changes to the code, add and commit them by running:

```bash
git add .
git commit -m "Added feature X"
```

1. Push your branch to the remote repository by running:

`git push -u origin my-feature`

1. Open a pull request on GitHub by following these steps:
    1. Open your repository on GitHub and switch to the "Pull requests" tab.
    2. Click on the "New pull request" button in the top-right corner.
    3. Choose the base branch (usually `main` or `master`) and the compare branch (your feature branch).
    4. Review the changes and add a title and description for your pull request.
    5. Click on "Create pull request" to submit it.
2. Review and discuss the code changes with your team members, and make additional commits as needed.
3. Merge the pull request into the base branch by following these steps:
    1. Open your pull request on GitHub and make sure that all the automated tests pass.
    2. Review the code changes and the comments.
    3. Click on the "Merge pull request" button and confirm the merge.
    4. Optionally, delete the source branch if you don't need it anymore.

## Resolving Conflicts

1. Fetch the latest changes from the remote repository by running:

`git fetch`

1. Merge the changes into your local branch by running:

`git merge origin/main`

1. Resolve any conflicts between your changes and the remote changes by editing the files and removing the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
2. Add and commit your changes by running:

```bash
git add .
git commit -m "Resolved conflicts with main branch"`
```

1. Push your changes to the remote branch by running:

`git push`

## Reviewing Changes

- Review the commit history and the code changes by running:

```bash
git log
git diff COMMIT1..COMMIT2
```

- Use GitHub's code review tools, such as inline comments and reviews, to discuss the changes with your team members.

That's it!
