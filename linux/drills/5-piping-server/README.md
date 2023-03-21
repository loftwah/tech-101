# Piping Server Drill

A guide on setting up and using Piping Server for transferring data between devices.

## Table of Contents

- [Piping Server Drill](#piping-server-drill)
  - [Table of Contents](#table-of-contents)
  - [Piping Server Overview](#piping-server-overview)
  - [Web User Interfaces](#web-user-interfaces)
  - [Streaming Data](#streaming-data)
  - [Installing and Running Piping Server](#installing-and-running-piping-server)
  - [Using Piping Server](#using-piping-server)

## Piping Server Overview

Piping Server is a tool that allows you to transfer data between devices using HTTP requests. Data sent to a specific path using POST or PUT requests can be retrieved using GET requests from the same path. Both sender and receiver can initiate the transfer, and the first one to start will wait for the other.

## Web User Interfaces

There are two web user interfaces available for Piping Server:

1. [Piping Server UI](https://ppng.io) - A basic web interface for Piping Server.
2. [Piping Server Modern UI](https://piping-ui.org) - A more modern web interface that supports end-to-end encryption.

## Streaming Data

Piping Server supports streaming data, which means you can transfer any data infinitely. The demo below transfers an infinite text stream with `seq inf`.

## Installing and Running Piping Server

To install and run the Piping Server using Docker, execute the following command:

```bash
docker run -p 8181:8080 nwtgck/piping-server-rust
```

## Using Piping Server

To use Piping Server for transferring data, follow these steps:

1. **Transmit**: Send the data using `curl`:

```bash
cat <filename> | curl -T - https://ppng.io/<filename>
```

2. **Receive**: Retrieve the data using `curl`:

```bash
curl https://ppng.io/<filename> > <filename>
```

Replace `<filename>` with the actual name of the file you want to transfer. The same filename should be used by both sender and receiver to ensure the correct data is transferred.
