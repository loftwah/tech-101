# Docker Practice Drill

A collection of useful Docker commands and installation guides for various platforms.

## Table of Contents

- [Docker Practice Drill](#docker-practice-drill)
  - [Table of Contents](#table-of-contents)
  - [Start Docker Daemon](#start-docker-daemon)
  - [Container Management](#container-management)
  - [Image Management](#image-management)
  - [Data Management](#data-management)
  - [Migrate Docker Image Without Registry](#migrate-docker-image-without-registry)
  - [Clean Up Docker](#clean-up-docker)
  - [Install Docker on Amazon Linux 2](#install-docker-on-amazon-linux-2)
  - [Install Docker on Linux](#install-docker-on-linux)
  - [Install Docker Compose](#install-docker-compose)
  - [Dockerfile Example](#dockerfile-example)

## Start Docker Daemon

```bash
docker -d
```

## Container Management

- Start a container with an interactive shell:

```bash
docker run -ti <image-name> /bin/bash
```

- Shell into a running container (docker-1.3+):

```bash
docker exec -ti <container-name> bash
```

- Inspect a running container:

```bash
docker inspect <container-name> (or <container-id>)
```

- Get the process ID for a container:

```bash
docker inspect --format {{.State.Pid}} <container-name-or-id>
```

- List currently running containers:

```bash
docker ps
```

- List all containers:

```bash
docker ps -a
```

- Remove all stopped containers:

```bash
docker rm $(docker ps -qa)
```

## Image Management

- List all images:

```bash
docker images
```

- Remove all untagged images:

```bash
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
```

## Data Management

- List (and pretty-print) the current mounted volumes for a container:

```bash
docker inspect --format='{{json .Volumes}}' <container-id> | python -mjson.tool
```

- Copy files/folders between a container and your host:

```bash
docker cp foo.txt mycontainer:/foo.txt
```

- Remove all volumes not used by at least one container:

```bash
docker volume prune
```

## Migrate Docker Image Without Registry

1. Save the Docker image as a tar file:

```bash
docker save -o <path for generated tar file> <image name>
```

Example:

```bash
docker save -o c:/myfile.tar centos:16
```

2. Copy your image to a new system with regular file transfer tools such as `cp`, `scp`, or `rsync` (preferred for big files).
3. Load the image into Docker:

```bash
docker load -i <path to image tar file>
```

## Clean Up Docker

Before starting, clean up Docker by running the following commands:

```bash
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

## Install Docker on Amazon Linux 2

Docker basics for Amazon ECS:

```bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
```

## Install Docker on Linux

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo service docker start
sudo systemctl enable docker
sudo usermod -aG docker <username>
```

A reboot may be required for this to work on Fedora.

## Install Docker Compose

Note: Use `bash` for this one, as `zsh` may produce a parse error.

Install Docker Compose with the following commands:

```bash
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
```

There is now a plugin version available for Docker Compose, which adds some ambiguity because it removes the `-` from the command.

For the `apt` package manager, installing the plugin looks something like this:

```bash
sudo apt-get install docker-compose-plugin
```

## Dockerfile Example

Dockerizing a simple NodeJS app:

```dockerfile
FROM node:latest
WORKDIR /app
ADD ./app
RUN npm install
EXPOSE 3000
CMD npm start
```
