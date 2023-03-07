# Interactive Shell

In Docker, you can start a container with an interactive shell, which allows you to interact with the container's command line in real time. In this tutorial, we'll discuss how to start a container with an interactive shell.

## Starting a Container with an Interactive Shell

To start a container with an interactive shell, you can use the `docker run` command with the `-it` flag. The `-it` flag tells Docker to allocate a pseudo-TTY terminal for the container, which allows you to interact with the container's command line in real time.

Here's an example command to start a container with an interactive shell:

`docker run -it <image_name> /bin/bash`

In this command, replace `<image_name>` with the name of the Docker image you want to run. The `/bin/bash` at the end of the command specifies that you want to run a Bash shell in the container.

Once you run this command, Docker will download the image (if it's not already downloaded), create a container from the image, and start the container with an interactive shell. You can then interact with the container's command line just as you would with a local terminal.

## Exiting the Container

To exit the container, simply type the `exit` command in the container's command line. This will exit the interactive shell and stop the container.

If you want to exit the container without stopping it, you can use the `CTRL + P` and `CTRL + Q` key combination. This detaches your terminal from the container's TTY, allowing you to exit without stopping the container.

## Conclusion

Starting a container with an interactive shell is a powerful feature of Docker that allows you to interact with the container's command line in real time. By using the `-it` flag with the `docker run` command, you can start a container with an interactive shell and interact with it just as you would with a local terminal.
