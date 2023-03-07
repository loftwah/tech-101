# Understanding Docker Images

Docker images are the building blocks of containers. In this tutorial, we'll discuss what Docker images are and how they are created.

## What is a Docker Image?

A Docker image is a read-only template that contains everything needed to run an application, including code, runtime, system tools, libraries, and settings. Docker images are created using a Dockerfile, which is a simple text file that contains instructions on how to build the image.

Docker images are stored in a registry, such as Docker Hub or a private registry, and can be pulled down and run on any Docker host. When you run a Docker container, Docker creates a writable layer on top of the image, where the application can store data and make changes.

## How is a Docker Image Created?

A Docker image is created using a Dockerfile, which is a simple text file that contains a set of instructions on how to build the image. The Dockerfile includes the following steps:

1. **Choose a base image**: The base image is the starting point for the Docker image. It includes the operating system and any system tools or libraries needed to run the application.
2. **Add application code**: The application code is added to the image using the ADD or COPY instruction. This step copies the files from the host system to the image.
3. **Install dependencies**: Any dependencies needed by the application are installed using the RUN instruction. This step installs any system packages or libraries required by the application.
4. **Set environment variables**: Environment variables are set using the ENV instruction. This step sets any environment variables required by the application.
5. **Expose ports**: Ports are exposed using the EXPOSE instruction. This step specifies which ports should be exposed by the container.
6. **Define the startup command**: The startup command is defined using the CMD instruction. This step specifies the command to run when the container starts up.

Once the Dockerfile is created, the Docker image can be built using the `docker build` command. This command reads the Dockerfile and builds the image according to the instructions.

## Conclusion

Docker images are read-only templates that contain everything needed to run an application. They are created using a Dockerfile, which includes instructions on how to build the image. By understanding how Docker images are created, you can create your own Docker images and use them to run your applications in containers.
