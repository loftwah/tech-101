# Git and GitHub Practice Drill

A collection of useful Git commands, configuration settings, and tips for working with GitHub.

## Table of Contents

- [Git and GitHub Practice Drill](#git-and-github-practice-drill)
  - [Table of Contents](#table-of-contents)
  - [Initial Git Configuration](#initial-git-configuration)
  - [Common Git Commands](#common-git-commands)
  - [Generate SSH Keys](#generate-ssh-keys)
  - [Generate and Auto-sign Commits with GPG](#generate-and-auto-sign-commits-with-gpg)

## Initial Git Configuration

```bash
git config --global user.name "Dean Lofts"
git config --global user.email "dean@deanlofts.xyz"
```

## Common Git Commands

- Remove deleted files from repo:

```bash
git rm $(git ls-files --deleted)
```

- Reset git repo (dangerous):

```bash
git reset --hard HEAD
```

- Reset and remove untracked changes in repo:

```bash
git clean -xdf
```

- Ignore certificates when cloning via HTTPS:

```bash
git config --global http.sslVerify false
```

- Pull changes and remove stale branches:

```bash
git pull --prune
```

- Grab the diff of a previous version of a file:

```bash
git diff HEAD@{1} ../../production.hosts
```

- Grab the diff of a staged change:

```bash
git diff --cached <file>
```

- Undo a commit to a branch:

```bash
git reset --soft HEAD~1
```

- View files changed in a commit:

```bash
git log --stat
```

- Pull latest changes, stashing changes first:

```bash
git pull --autostash
```

- Make an empty commit (good for CI):

```bash
git commit --allow-empty -m "Trigger notification"
```

- Change remote repository URL:

```bash
git remote set-url origin git://new.location
```

- Fix ".gitignore not working" issue:

  1. Update `.gitignore` with the folder/file name you want to ignore.
  2. Commit all the changes to git, excluding the folder/files you don't want to commit.
  3. Execute the following command to clear the cache: `git rm -r --cached .`
  4. Execute `git status` command and it should output the ignored folders/files marked for deletion.
  5. Now execute:

```bash
git add .
git commit -m "fixed untracked files"
git push
```

## Generate SSH Keys

Generate an SSH key with the following:

```bash
ssh-keygen -t rsa -b 4096 -C "dean@deanlofts.xyz"
cat ~/.ssh/id_rsa.pub
```

Put your SSH key into GitHub if you intend to use it this way.

## Generate and Auto-sign Commits with GPG

Automatically sign your commits with a GPG key, giving you a verified badge on your GitHub commits. Make sure you don't set a passphrase for your GPG key.

1. Generate a key:

```bash
gpg --gen-key
```

2. See your GPG public key:

```bash
gpg --armor --export YOUR_KEY_ID
```

3. Set a GPG key for Git:

```bash
git config --global user.signingkey your_key_id
```

4. To sign a single commit:

```bash
git commit -S -a -m "Test a signed commit"
```

5. Auto-sign all commits globally:

```bash
git config --global commit.gpgsign true
```

Be sure to add your key to your GitHub account.
