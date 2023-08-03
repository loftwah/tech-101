# Morse Code Animation with Manim

This project generates an animation of Morse code using the Manim library in Python.

## Prerequisites

Before you begin, ensure you have met the following requirements:

* You have installed Docker.
* You have a basic understanding of Python, Docker, and how to clone a repository from GitHub.

## Installing Morse Code Animation with Manim

To install the project and the required Python libraries, follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/loftwah/tech-101
cd tech-101/misc/drills/4-morse-code
```

2. Build the Docker image:

```bash
docker compose build
```

## Using Morse Code Animation with Manim

To use Morse Code Animation, follow these steps:

1. Run the Docker container:

```bash
docker compose up
```

This will generate an MP4 video in the `media/videos/` directory of the host system.

## Cleaning up

To remove the Docker container and network created by `docker-compose up`, you can use the following command:

```bash
docker compose down
```
