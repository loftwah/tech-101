# Linux Customizations Drill

A guide on installing and configuring additional applications on top of Linux.

## Table of Contents

- [Linux Customizations Drill](#linux-customizations-drill)
  - [Table of Contents](#table-of-contents)
  - [Linuxbrew](#linuxbrew)
  - [Zsh and Oh My Zsh](#zsh-and-oh-my-zsh)
  - [Powerline Fonts](#powerline-fonts)
  - [Zsh Plugins](#zsh-plugins)

## Linuxbrew

Install Linuxbrew by following these instructions:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Zsh and Oh My Zsh

Install Zsh and Oh My Zsh by following these instructions:

1. Install Zsh:

```bash
sudo apt install zsh -y
sudo chsh -s $(which zsh)
```

2. Install Oh My Zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Powerline Fonts

Install Powerline Fonts by following these instructions:

```bash
sudo apt install fonts-powerline -y
```

## Zsh Plugins

Install Zsh plugins for autosuggestions and syntax highlighting:

1. Install Zsh Autosuggestions:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

2. Install Zsh Syntax Highlighting:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

You need to update the `~/.zshrc` file to add the plugins. If you're using a file stored somewhere else, create a link to the file in your home directory with `ln -s /dotfiles/.zshrc ~/.zshrc`. This will create a symlink to the file so you can store it in a Git repository.

Add the plugins to your `~/.zshrc` file:

```
bash
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```
