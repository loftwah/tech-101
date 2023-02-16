# Docker Intro

Docker is a popular platform for building, shipping, and running applications in containers. Containers provide a lightweight and portable way to package and deploy software, allowing you to build and run your applications consistently across different environments.

## Getting Started

To get started with Docker, you will need to have Docker installed on your machine. You can download the latest version of Docker from the [official Docker website](https://www.docker.com/products/docker-desktop).

Once you have Docker installed, you can open a Docker terminal by running the Docker Desktop application.

## Images

In Docker, an image is a lightweight, standalone, and executable package that includes everything needed to run an application, including code, libraries, and dependencies. You can think of an image as a template for creating containers.

You can create a new image using a Dockerfile, which is a simple text file that specifies the components and settings needed to build the image. Here is an example of a Dockerfile:

```Dockerfile
FROM ruby:2.7-alpine

RUN apk add --update --no-cache \
  build-base \
  nodejs \
  yarn \
  postgresql-dev \
  tzdata

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
```

This Dockerfile creates a new image based on the `ruby:2.7-alpine` image, which is a lightweight Alpine Linux-based image that includes Ruby 2.7. It installs the necessary packages and sets the working directory to `/app`. It then copies the `Gemfile` and `Gemfile.lock` files to the working directory and installs the Ruby gems using `bundle install`. Finally, it copies the rest of the application files and sets the default command to run the Rails server.

You can build the image using the following command:

`docker build -t myapp .`

This builds a new image with the tag `myapp`.

## Containers

In Docker, a container is a runtime instance of an image. You can think of a container as a lightweight, isolated, and self-contained environment that includes everything needed to run the application.

You can create a new container using the following command:

`docker run -p 3000:3000 myapp`

This creates a new container from the `myapp` image and maps the host port `3000` to the container port `3000`.

## Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications. It allows you to define a set of services and their dependencies in a `docker-compose.yml` file, and then use a single command to start and stop the entire application.

Here is an example of a `docker-compose.yml` file for a Ruby on Rails application:

```yml
version: '3.7'

services:
  db:
    image: postgres
    volumes:
      - ./tmp/db:/var/lib/postgresql/data

  web:
    build: .
    command: rails server -b 0.0.0.0
    volumes:
      - .:/app
    ports:
      - "3000:3000"
    depends_on:
      - db
  ```

This file defines two services, `db` and `web`. The `db` service uses the `postgres` image and mounts a volume for persistent data. The `web` service builds the image using the Dockerfile in the current directory, sets the default command to run the Rails server, and mounts the current directory as a volume. It also maps the host port `3000` to the container port `3000` and sets the `db` service as a dependency.

You can start the application using the following command:

`docker-compose up`

This starts the `db` and `web` services and attaches the terminal to the logs.

## Conclusion

Docker provides a powerful and flexible platform for building, shipping, and running applications in containers. Its support for images, containers, Dockerfiles, and Docker Compose make it easy to package and deploy your applications, while its portability and scalability make it a great choice for a wide range of use cases. If you're new to Docker, I encourage you to give it a try and see how it can help streamline your development and deployment workflows.
