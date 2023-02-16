# Developer Introduction and Guide

## Overview

Welcome to our software team! This guide will walk you through the installation, configuration, and usage of the tools we use.

![Developer Introduction and Guide](https://user-images.githubusercontent.com/19922556/219306819-6c419776-5fe3-43b6-80ac-fe21866db870.jpg)

## Tools

* **1Password**: password manager that securely stores and shares passwords and other sensitive information.
* **Google Workspace**: a suite of productivity and collaboration tools including Gmail, Google Drive, Docs, Sheets, and Slides.
* **OneLogin**: cloud-based identity and access management service that provides secure single sign-on, multi-factor authentication, and user provisioning.
* **Node Version Manager (nvm)**: a tool to manage multiple versions of Node.js on a single system.
* **Docker**: a containerization platform that allows developers to build, package, and deploy applications in a portable and scalable way.
* **Terraform**: infrastructure-as-code tool used to automate the provisioning and management of cloud resources.
* **Homebrew**: package manager for macOS and Linux that allows you to easily install and manage software packages and libraries.
* **AWS CLI**: command-line interface for AWS that allows you to manage your AWS services and resources.
* **Git**: version control system that allows developers to track changes to code, collaborate with others, and manage code releases.
* **PostgreSQL**: open-source relational database management system.
* **rbenv**: a tool to manage multiple versions of the Ruby programming language on a single system.
* **Visual Studio Code**: a free and open-source code editor developed by Microsoft.
* **Vim**: a highly configurable, powerful, and efficient text editor.

## Installation and Setup

This section will walk you through the installation and setup of the tools we use.

### 1Password

1. Go to the [1Password website](https://1password.com/) and download the app for your operating system.
2. Follow the installation instructions.
3. Set up your 1Password account and log in.
4. Install the 1Password CLI by following the instructions in the [1Password documentation](https://support.1password.com/command-line-getting-started/).

### Google Workspace

1. Go to the [Google Workspace website](https://workspace.google.com/) and sign up for an account.
2. Follow the setup instructions.
3. Access your Google Workspace apps by visiting the [Google Workspace homepage](https://www.google.com/intl/en_us/gmail/about/#) and logging in.

### OneLogin

1. Go to the [OneLogin website](https://www.onelogin.com/) and sign up for an account.
2. Follow the setup instructions.
3. Access your OneLogin dashboard by visiting the [OneLogin login page](https://www.onelogin.com/login) and logging in.

### Node Version Manager (nvm)

Linux and macOS

1. Open your terminal and run the following command to install nvm:
 `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash`
2. Close and reopen your terminal.
3. Verify that nvm is installed by running the following command:
    `nvm --version`

### Docker

Linux

1. Follow the instructions in the [Docker documentation](https://docs.docker.com/engine/install/ubuntu/) for your distribution.
2. Verify that Docker is installed by running the following command:
 `docker --version`

macOS

1. Go to the [Docker website](https://www.docker.com/) and download the app for macOS.
2. Follow the installation instructions.
3. Verify that Docker is installed by running the following command:
 `docker --version`

### Terraform

#### Installing with tfenv (recommended)

tfenv is a version manager for Terraform that makes it easy to install and use multiple versions of Terraform on the same system.

1. Open your terminal and run the following commands to install tfenv:

```bash
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

1. Install the desired version of Terraform by running the following command:

`tfenv install 1.3.8`

1. Set the global version of Terraform by running the following command:

`tfenv use 1.3.8`

1. Verify that Terraform is installed and the correct version is set by running the following commands:

```bash
tfenv --version
terraform --version
```

#### Installing without tfenv

Linux and macOS

1. Open your terminal and run the following command to download the latest Terraform release for your operating system:

`curl -O https://releases.hashicorp.com/terraform/1.3.8/terraform_1.3.8_darwin_amd64.zip`

1. Unzip the downloaded file and move the binary to a directory in your system's `PATH`.
2. Verify that Terraform is installed by running the following command:

`terraform --version`

Windows

1. Go to the [Terraform website](https://www.terraform.io/downloads.html) and download the appropriate package for Windows.
2. Follow the installation instructions.
3. Verify that Terraform is installed by running the following command:

`terraform --version`

Note: We recommend using tfenv to manage multiple versions of Terraform on the same system.

### Homebrew

macOS

1. Open your terminal and run the following command to install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Close and reopen your terminal.
3. Verify that Homebrew is installed by running the following command: `brew --version`

Linux

1. Follow the instructions in the [Homebrew documentation](https://docs.brew.sh/Homebrew-on-Linux) to install Homebrew for Linux.
2. Verify that Homebrew is installed by running the following command: `brew --version`

### AWS CLI

Linux and macOS

1. Open your terminal and run the following command to install the AWS CLI: `sudo apt-get install awscli -y` (for Linux) `brew install awscli` (for macOS)
2. Verify that AWS CLI is installed by running the following command: `aws --version`

Windows

1. Go to the [AWS CLI website](https://aws.amazon.com/cli/) and download the app for Windows.
2. Follow the installation instructions.
3. Verify that AWS CLI is installed by running the following command: `aws --version`

### Git

Linux and macOS

1. Open your terminal and run the following command to install Git: `sudo apt-get install git -y` (for Linux) `brew install git` (for macOS)
2. Verify that Git is installed by running the following command: `git --version`

Windows

1. Go to the [Git website](https://git-scm.com/download/win) and download the app for Windows.
2. Follow the installation instructions.
3. Verify that Git is installed by running the following command: `git --version`

#### Initial Git Configuration

1. Open your terminal and run the following commands to set up your Git configuration: `git config --global user.name "Your Name"` `git config --global user.email "youremail@example.com"`
2. Set up your PGP key by following the [GitHub documentation](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key).
3. Set up automatic signed commits by running the following command: `git config --global commit.gpgsign true`

### PostgreSQL

Linux

1. Open your terminal and run the following command to install PostgreSQL: `sudo apt-get install postgresql postgresql-contrib -y`
2. Verify that PostgreSQL is installed by running the following command: `psql --version`

macOS

1. Open your terminal and run the following command to install PostgreSQL: `brew install postgresql`
2. Verify that PostgreSQL is installed by running the following command: `psql --version`

Windows

1. Go to the [PostgreSQL website](https://www.postgresql.org/download/windows/) and download the installer for Windows.
2. Follow the installation instructions.
3. Verify that PostgreSQL is installed by running the following command: `psql --version`

### rbenv

Linux and macOS

1. Open your terminal and run the following command to install rbenv: `curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash`
2. Add the following line to your `~/.bashrc` or `~/.zshrc` file: `eval "$(rbenv init -)"`
3. Close and reopen your terminal.
4. Install the desired version of Ruby by running the following command: `rbenv install <version>`
5. Set the global version of Ruby by running the following command: `rbenv global <version>`
6. Verify that rbenv is installed and the correct version of Ruby is set by running the following commands: `rbenv --version` `ruby --version`

Windows

1. Go to the [RubyInstaller website](https://rubyinstaller.org/downloads/) and download the latest version of Ruby.
2. Follow the installation instructions.
3. Verify that Ruby is installed by running the following command: `ruby --version`

### Visual Studio Code

Visual Studio Code is a free, open-source code editor with built-in support for a wide range of programming languages.

Linux

1. Follow the instructions in the [Visual Studio Code documentation](https://code.visualstudio.com/docs/setup/linux) to install Visual Studio Code for Linux.
2. Verify that Visual Studio Code is installed by running the following command: `code --version`

macOS

1. Go to the [Visual Studio Code website](https://code.visualstudio.com/) and download the app for macOS.
2. Follow the installation instructions.
3. Verify that Visual Studio Code is installed by running the following command: `code --version`

Windows

1. Go to the [Visual Studio Code website](https://code.visualstudio.com/) and download the app for Windows.
2. Follow the installation instructions.
3. Verify that Visual Studio Code is installed by running the following command: `code --version`

### Vim

Vim is a highly configurable text editor built to enable efficient text editing.

Linux and macOS

1. Open your terminal and run the following command to install Vim: `sudo apt-get install vim -y` (for Linux) `brew install vim` (for macOS)
2. Verify that Vim is installed by running the following command: `vim --version`

Windows

1. Go to the [Vim website](https://www.vim.org/download.php#pc) and download the installer for Windows.
2. Follow the installation instructions.
3. Verify that Vim is installed by running the following command: `vim --version`

## Usage

1. Clone the repository to your local machine using Git.
2. Install any necessary dependencies by running the appropriate commands for your project.
3. Set up your development environment by configuring your IDE, setting environment variables, and installing any necessary libraries or packages.
4. Use Terraform to provision any necessary cloud resources.
5. Use Docker to build and deploy your application.
6. Use AWS CLI to manage your AWS resources.
7. Use PostgreSQL to manage your database.
8. Use rbenv to manage the version of Ruby used for your project.
9. Use 1Password CLI to manage your 1Password account and vaults from the terminal.
10. Use Visual Studio Code or Vim to edit your code.

## References

* Documentation for each tool can be found on their respective websites or in their GitHub repositories.
* For questions or help with any tool, please consult with your team lead or reach out to the appropriate support channel.
