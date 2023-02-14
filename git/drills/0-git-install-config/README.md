# Git installation, configuration, and key generation on Mac

This drill is designed to help you or your team learn how to install and configure Git on a Mac, and use it with GitHub securely.

## Installing Git using Homebrew

1. Open Terminal.app (you can find it in /Applications/Utilities or by using Spotlight).
2. Install Homebrew by running the following command:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

1. Verify that Homebrew is installed and up-to-date by running:

`brew update`

1. Install Git with Homebrew by running:

`brew install git`

## Configuring Git to work with GitHub

1. Open Terminal.app.
2. Set your username and email address in Git by running:

```bash
git config --global user.name "YOUR_USERNAME"
git config --global user.email "YOUR_EMAIL"
```

1. Check that the configuration was successful by running:

`git config --global --list`

1. Generate an SSH key for your GitHub account by running:

`ssh-keygen -t ed25519 -C "YOUR_EMAIL"`

1. Copy the public key to your clipboard by running:

`pbcopy < ~/.ssh/id_ed25519.pub`

1. Add the public key to your GitHub account by following these steps:
    1. Log in to your GitHub account and click on your profile picture in the top-right corner.
    2. Click on "Settings" in the dropdown menu.
    3. Click on "SSH and GPG keys" in the left sidebar.
    4. Click on "New SSH key" or "Add SSH key".
    5. Paste your public key into the "Key" field and give it a title.
    6. Click on "Add SSH key".

## Generating PGP keys and setting up self-signing

1. Open Terminal.app.
2. Install GPG with Homebrew by running:

`brew install gpg`

1. Generate a new PGP key pair by running:

`gpg --full-generate-key`

1. Follow the prompts to choose the type of key, key size, expiration date, and so on. Make sure to use the same email address you used for your GitHub account.
2. List your keys by running:

`gpg --list-keys`

1. Export your public key by running:

`gpg --export --armor YOUR_KEY_ID > publickey.asc`

1. Import your public key into your GitHub account by following these steps:
    1. Log in to your GitHub account and click on your profile picture in the top-right corner.
    2. Click on "Settings" in the dropdown menu.
    3. Click on "SSH and GPG keys" in the left sidebar.
    4. Click on "New GPG key" or "Add GPG key".
    5. Paste the contents of the `publickey.asc` file into the "Key" field and give it a title.
    6. Click on "Add GPG key".
2. Sign your commits and tags with your PGP key by running:

```bash
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
```

## Using Git with SSH and HTTPS

Git can use either the SSH or HTTPS protocol to communicate with remote repositories, such as GitHub. Here are the main differences between the two:

* With SSH, you authenticate with a public/private key pair, which is more secure than using a password. You can also use PGP keys for additional security. However, you need to set up your public key on the remote server (e.g., GitHub) before you can use it, and you need to have the corresponding private key on your local machine. Additionally, some firewalls may block SSH traffic.

* With HTTPS, you authenticate with your GitHub username and password (or a personal access token). This is easier to set up, but less secure, as your password is transmitted in plaintext over the network. However, GitHub supports two-factor authentication (2FA) for added security, and you can use a credential manager to avoid typing your password every time.

You can switch between SSH and HTTPS for a given repository by changing the URL of the remote origin. To use SSH, the URL should start with `git@github.com:` followed by the username and repository name (e.g., `git@github.com:myusername/myrepo.git`). To use HTTPS, the URL should start with `https://github.com/` followed by the username and repository name (e.g., `https://github.com/myusername/myrepo.git`).

To manage your credentials, you can use a credential helper, which stores your username and password or access token in an encrypted file. Git comes with several built-in helpers, such as the macOS Keychain for HTTPS, and the SSH agent for SSH. You can also use third-party helpers, such as Git Credential Manager Core (GCM Core) for cross-platform support.

That's it! I hope this drill helps you or your team learn how to install and configure Git on a Mac, and use it with GitHub securely. Let me know if you have any questions or feedback.
