# Encoder Script

This is a simple Bash script that allows you to encode and decode text using `gzip` and `base64` encoding. The script takes an input text or file and encodes it using `gzip` and `base64`, then prints the resulting encoded text to the console. You can also choose to include decoding instructions with the encoded text, which will allow you to decode the message later.

## How it works

The script takes an input text or file and compresses it using the `gzip` command. The compressed data is then encoded using the `base64` command, which converts the binary data to a printable ASCII string. Finally, the encoded string is printed to the console.

To decode the message, you can reverse this process by decoding the `base64` string and then using the `gunzip` command to decompress the binary data.

## Prerequisites

Before you can use this script, you need to make sure that the `gzip` and `base64` commands are installed on your system. On most Linux and Unix-based systems, these commands are included by default. You can check if they are installed by running the following commands:

```bash
gzip -h
base64 -h
```

If the commands are not found, you may need to install them using your system's package manager.

## Usage

The `encoder.sh` script can be used to encode a given text or file using `gzip` and `base64` encoding. You can choose to encode the text with or without decoding instructions.

To encode a text string, run the script with the `-e` flag followed by the text in quotes:

`./encoder.sh -e "Once upon a time"`

This will print the encoded string to the console:

`H4sIAAAAAAAAA/PPS05VKC3Iz1NIVCjJzE3lAgB/CBp0EQAAAA==`

To encode a file, run the script with the `-e` flag followed by the path to the file:

`./encoder.sh -e /path/to/file.txt`

This will read the contents of the file and print the encoded string to the console.

To encode the text with decoding instructions, use the `-ed` flag instead of the `-e` flag:

`./encoder.sh -ed "Once upon a time"`

This will print the encoded string along with the decoding instructions:

```bash
#To decode the message, run the following command:
echo 'H4sIAAAAAAAAA/PPS05VKC3Iz1NIVCjJzE3lAgB/CBp0EQAAAA==' | base64 -d | gunzip

#Encoded message:
H4sIAAAAAAAAA/PPS05VKC3Iz1NIVCjJzE3lAgB/CBp0EQAAAA==
```

To decode the message later, copy the encoded string and paste it into the decoding command:

`echo 'H4sIAAAAAAAAA/PPS05VKC3Iz1NIVCjJzE3lAgB/CBp0EQAAAA==' | base64 -d | gunzip`

This will print the original text to the console:

`Once upon a time`

You can also decode a file by running the `base64` and `gunzip` commands separately. First, use `base64` to decode the file:

`base64 -d /path/to/encoded/file.txt > decoded.gz`

This will create a new file called `decoded.gz` that contains the compressed data. You can then use the `gunzip` command to decompress the data and create a new file with the original contents:

`gunzip decoded.gz`

This will create a new file called `decoded` that contains the original contents of the file.
