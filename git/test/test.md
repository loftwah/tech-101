# Git Mock Test Questions

These are some mock questions that you can use to test your knowledge of Git.

## Multiple Choice Questions

1. What command is used to clone a Git repository to a local machine?

    a) `git init`

    b) `git clone`

    c) `git sync`

    d) `git pull`

    <details> <summary>Answer</summary>

    b

    </details>
2. What command is used to create a new branch in Git?

    a) `git add`

    b) `git commit`

    c) `git checkout`

    d) `git branch`

    <details> <summary>Answer</summary>

    d

    </details>
3. What is a merge conflict in Git?

    a) A situation where two branches have conflicting changes that cannot be automatically merged

    b) A situation where the remote repository cannot be reached

    c) A situation where a branch is deleted without being merged first

    d) A situation where a branch is merged without being tested first

    <details> <summary>Answer</summary>

    a

    </details>
4. What command is used to view the status of your repository in Git?

    a) `git add`

    b) `git status`

    c) `git commit`

    d) `git push`

    <details> <summary>Answer</summary>

    b

    </details>
5. What is the purpose of forking a repository in Git?

    a) To create a new repository based on an existing one

    b) To merge changes from one branch to another

    c) To create a new branch for testing changes

    d) To delete an existing branch

    <details> <summary>Answer</summary>

    a

    </details>

## Written Answer Questions

1. Describe the steps you would take to initialize a Git repository in a new project directory.

    <details>
    <summary>Answer</summary>

    ```bash
    1.  Open a command prompt or terminal window.
    2.  Navigate to the project directory.
    3.  Run the command "git init".
    4.  Add files to the repository using the command "git add".
    5.  Commit the changes to the repository using the command "git commit".
    ```
    </details>

2. What is the purpose of a Git branch? Describe how branches can be used to manage changes in a project.

    <details>
    <summary>Answer</summary>

    ```bash
    A Git branch is a separate line of development that allows developers to work on changes independently of the main branch. Branches can be used to manage changes in a project by allowing developers to work on separate features or bug fixes without affecting the main branch. Changes can be merged back into the main branch when they are complete and have been tested.
    ```

    </details>

3. Describe the steps you would take to rollback to a previous commit in Git.

    <details>
    <summary>Answer</summary>

    ```bash
    1.  Determine the commit hash of the previous commit that you want to rollback to using "git log".
    2.  Create a new branch to rollback to the previous commit using `git checkout -b <new-branch-name>`.
    3.  Reset the repository to the previous commit using `git reset --hard <commit-hash>`.
    4.  Review the changes made by the rollback and ensure that they are correct.
    5.  Push the changes to the remote branch using `git push -f origin <new-branch-name>`.
    ```

    </details>

4. What is the purpose of forking a repository in Git, and how can changes made to a forked repository be merged back into the original repository?

    <details>
    <summary>Answer</summary>

    ```bash
    Forking a repository in Git allows you to create a new copy of the repository that you can modify without affecting the original repository. Changes made to a forked repository can be merged back into the original repository by creating a pull request. The pull request allows the changes to be reviewed and approved by the repository owner before they are merged.
    ```

    </details>

5. What is a Git merge conflict, and how can conflicts be resolved in Git?

    <details>
    <summary>Answer</summary>

    ```bash
    A Git merge conflict occurs when two branches have conflicting changes that cannot be automatically merged. Conflicts can be resolved in Git by manually editing the files that have conflicts and choosing which changes to keep. Once the conflicts have been resolved, the changes can be committed and merged into the main branch. It's important to communicate with team members to avoid conflicts and ensure that everyone is on the same page.
    ```

    </details>
