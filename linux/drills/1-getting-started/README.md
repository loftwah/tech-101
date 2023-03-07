# Getting started with Linux

1. The main topic of this drill is Linux and how to install and configure Linuxbrew and zsh with plugins.
2. [Ubuntu Server Download](https://ubuntu.com/download/server)
3. [Linux Basics](https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-basics)
4. [How to Set Up SSH Keys on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)
5. [How to Create an SSH Shortcut](https://www.digitalocean.com/community/tutorials/how-to-create-an-ssh-shortcut)
6. [Self Signed Certificate with Custom Root CA](https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309)
7. Linuxbrew is a package manager for Linux. To install Linuxbrew, run the following command:

    `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

9. zsh is a shell that is similar to bash but with more features and customization options. To install zsh, run the following commands:

```bash
    sudo apt install zsh -y
    sudo chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo apt install fonts-powerline -y
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

10. To update the `~/.zshrc` file to add plugins, add the following lines to the file:

```bash
    plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    )
```

If you're using a file stored somewhere else, create a symlink to the file in your home directory with `ln -s /dotfiles/.zshrc ~/.zshrc`. This will create a symlink to the file so you can store it in a `Git` repository.
