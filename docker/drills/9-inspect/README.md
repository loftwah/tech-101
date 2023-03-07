# Inspecting in Docker

In Docker, you can inspect a running container to retrieve information about its configuration, networking, and resource usage. In this tutorial, we'll discuss how to inspect a running container and what information you can retrieve using this command.

## Inspecting a Running Container

To inspect a running container, you can use the `docker inspect` command followed by the container's name or ID. This command displays a detailed JSON output containing information about the container.

Here's an example command to inspect a running container:

`docker inspect <container_name_or_id>`

In this command, replace `<container_name_or_id>` with the name or ID of the running container you want to inspect.

## Information Available from `docker inspect`

The `docker inspect` command provides a detailed JSON output that contains information about the container's configuration, networking, and resource usage. Here are some of the information you can retrieve using this command:

* **Container configuration**: You can retrieve information about the container's configuration, such as the container's hostname, environment variables, command, and exposed ports.
* **Network settings**: You can retrieve information about the container's network settings, such as the container's IP address, network mode, and network interfaces.
* **Resource usage**: You can retrieve information about the container's resource usage, such as CPU and memory usage, network and disk I/O, and process status.
* **Metadata**: You can retrieve metadata about the container, such as the container's ID, name, and creation time.

## Conclusion

Inspecting a running container is a useful feature of Docker that allows you to retrieve detailed information about the container's configuration, networking, and resource usage. By using the `docker inspect` command, you can retrieve a detailed JSON output that contains information about the container. This information can be useful for troubleshooting issues, debugging, and monitoring the container's performance.
