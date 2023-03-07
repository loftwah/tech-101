# Running Container Access

In Docker, you can shell into a running container to interact with its command line. This allows you to execute commands and perform actions inside the container. In this tutorial, we'll discuss how to shell into a running container.

## Shelling into a Running Container

To shell into a running container, you can use the `docker exec` command with the `-it` flag. The `-it` flag tells Docker to allocate a pseudo-TTY terminal for the container, which allows you to interact with the container's command line in real time.

Here's an example command to shell into a running container:

`docker exec -it <container_name_or_id> /bin/bash`

In this command, replace `<container_name_or_id>` with the name or ID of the running container you want to shell into. The `/bin/bash` at the end of the command specifies that you want to run a Bash shell in the container.

Once you run this command, Docker will attach your terminal to the container's TTY, allowing you to interact with the container's command line just as you would with a local terminal.

## Exiting the Container

To exit the container, simply type the `exit` command in the container's command line. This will exit the interactive shell and detach your terminal from the container's TTY.

If you want to exit the container without stopping it, you can use the `CTRL + P` and `CTRL + Q` key combination. This detaches your terminal from the container's TTY, allowing you to exit without stopping the container.

## Conclusion

Shelling into a running container is a powerful feature of Docker that allows you to interact with the container's command line in real time. By using the `docker exec` command with the `-it` flag, you can shell into a running container and interact with it just as you would with a local terminal.
