# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Copy the manim.cfg file into the container at /app
COPY manim.cfg /app/manim.cfg

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN apt-get update && \
    apt-get install -y \
    libcairo2-dev \
    libpango1.0-dev \
    libglib2.0-dev \
    libffi-dev \
    shared-mime-info \
    ffmpeg \
    build-essential && \
    pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/media/videos

# Run manim when the container launches
CMD ["manim", "-p", "-ql", "morse.py", "MorseCode"]
