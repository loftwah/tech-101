# Install Ubuntu Server

1. Download the Ubuntu Server ISO from the official Ubuntu website. Choose the latest LTS version, which is the most stable and has long-term support. You can also download the non-LTS version if you need the latest features and updates.
2. Create a bootable USB drive using a tool like Rufus or Etcher. Make sure to select the correct ISO file and USB drive. This will erase all data on the USB drive, so make sure to back up any important data before proceeding.
3. Insert the USB drive into the server that you want to install Ubuntu on and boot from it. You may need to change the boot order in the BIOS settings to prioritize the USB drive over other boot devices.
4. Choose the language you want to use for the installation process and select "Install Ubuntu Server" from the menu.
5. Follow the prompts to configure the time zone, keyboard layout, and network settings. If you are using DHCP, the network settings should be automatically detected. Otherwise, you will need to manually configure the IP address, subnet mask, gateway, and DNS settings.
6. Create a user account and password when prompted. This user account will have administrative privileges and can be used to perform system tasks and install software.
7. Choose the installation type - you can select the default option to erase the entire disk and install Ubuntu, or choose manual partitioning if you need more control over the installation. If you choose manual partitioning, you will need to create partitions for the root file system, swap space, and any other partitions you need.
8. Wait for the installation to complete and reboot the server. Remove the USB drive when prompted and let the server boot from the hard disk.

## Navigate the Command Line Interface

Once Ubuntu Server is installed, you can log in and start using the command line interface (CLI). Here are some basic commands and concepts to get started:

* The CLI is a text-based interface where you can enter commands to interact with the system. It is also known as the terminal or console.
* To log in to Ubuntu Server, enter the username and password you created during installation. You will see a welcome message and a command prompt.
* The command prompt usually shows your username, hostname, and the current directory. For example, `username@hostname:/path/to/directory$`.
* To navigate the file system, use the `cd` command followed by the name of the directory you want to navigate to. For example, `cd /var/log` will take you to the log directory. Use `cd ..` to go up one level in the directory hierarchy.
* To view the contents of a directory, use the `ls` command. For example, `ls /var/log` will show you the files and directories in the log directory. Use `ls -l` for a detailed list format, or `ls -a` to show hidden files.
* To execute a command or program, simply enter the name of the command or program and any necessary parameters. For example, `ls -l` will show you the contents of a directory in a detailed list format.
* To get help with a command or program, use the `man` command followed by the name of the command or program. For example, `man ls` will show you the manual page for the `ls` command.
* To shut down or reboot the system, use the `shutdown` command. For example, `sudo shutdown -h now` will shut down the system immediately. Use `sudo reboot` to reboot the system.

Congratulations! You have now installed Ubuntu Server and learned how to navigate the command line interface. With this foundation, you can start exploring the various features and capabilities of Ubuntu Server, as well as the tools and software packages that are available.

As a developer or DevOps engineer, you will likely spend a lot of time working with the command line interface, so it's important to become comfortable with basic commands and concepts. You can learn more advanced commands and techniques by reading documentation, watching tutorials, and practicing on your own.

Here are some additional topics that you may want to explore:

* Package management: Ubuntu uses the Advanced Package Tool (APT) to manage software packages and dependencies. You can use the `apt` command to search for, install, and remove packages. For example, `sudo apt update` updates the package lists, and `sudo apt install package-name` installs a package.
* User and group management: Ubuntu allows you to create and manage users and groups with different levels of access and permissions. You can use the `adduser` and `usermod` commands to create and modify users, and the `addgroup` and `groupmod` commands to create and modify groups.
* Network configuration: Ubuntu supports a wide range of network interfaces and protocols, and you can configure them using the `ip` and `ifconfig` commands. You can also configure DNS, routing, and firewall rules using tools like `iptables` and `ufw`.
* Process management: Ubuntu allows you to view and manage running processes using the `ps` and `top` commands. You can also start, stop, and monitor services using the `systemctl` command.

By learning these topics and practicing on your own, you can become proficient in working with Ubuntu Server and use it to develop and deploy applications and services. Good luck!
