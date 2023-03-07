# Getting Started with Linux

This guide is intended for beginners who are new to Linux and want to learn how to install and configure Linuxbrew and zsh with plugins.

## Prerequisites

Before you begin, you will need:

* A Linux distribution installed on your computer or a virtual machine. For this guide, we will be using Ubuntu Server. You can download it from the [official website](https://ubuntu.com/download/server).
* Basic knowledge of the Linux command line interface (CLI).

## Introduction to Linux

If you are new to Linux, it is recommended to learn the basics first. You can start with the following resources:

* [An Introduction to Linux Basics](https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-basics)

## Setting Up SSH Keys

To connect to your Linux server, you will need to set up SSH keys. You can follow this guide to set up SSH keys on Ubuntu:

* [How to Set Up SSH Keys on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)

## Creating an SSH Shortcut

To simplify the process of connecting to your Linux server, you can create an SSH shortcut. You can follow this guide to create an SSH shortcut:

* [How to Create an SSH Shortcut](https://www.digitalocean.com/community/tutorials/how-to-create-an-ssh-shortcut)

## Installing Linuxbrew

Linuxbrew is a package manager for Linux that allows you to easily install and manage software packages. To install Linuxbrew, run the following command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After the installation is complete, add Linuxbrew to your PATH environment variable by running the following command:

```bash
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>~/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
```

## Installing zsh and Plugins

zsh is a shell that is similar to bash but with more features and customization options. To install zsh, run the following commands:

```bash
sudo apt install zsh -y
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt install fonts-powerline -y
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

After the installation is complete, update the `~/.zshrc` file to add the zsh plugins by adding the following lines to the file:

```bash
    plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    )
```

If you have a `.zshrc` file stored somewhere else, create a symlink to the file in your home directory with the following command:

`ln -s /path/to/.zshrc ~/.zshrc`

This will create a symlink to the file so you can store it in a `Git` repository.

## Generating a Self-Signed Certificate

If you want to use HTTPS with your Linux server, you can generate a self-signed certificate. You can follow this guide to generate a self-signed certificate with a custom root CA:

* [Self Signed Certificate with Custom Root CA](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309)

## Conclusion

Congratulations! You have successfully installed Linuxbrew and zsh with plugins on your Linux server. With these tools, you can easily install and manage software packages and customize your shell environment. If you want to learn more about Linux, there are many resources available online to help you continue your journey.
