#!/bin/bash

# Define usage function
usage () {
  echo "Usage: $0 [-h] [-e | -ed] [TEXT | FILE]"
  echo "Encode or encode with decoding instructions a given text or file."
  echo ""
  echo "Options:"
  echo "-h: Show help message"
  echo "-e: Encode the input text or file"
  echo "-ed: Encode the input text or file and include decoding instructions"
  echo ""
  echo "Examples:"
  echo "Encode text: $0 -e 'Once upon a time'"
  echo "Encode file: $0 -e file.txt"
  echo "Encode with instructions: $0 -ed 'Once upon a time'"
}

# Parse command line arguments
while getopts "he:d:" opt; do
  case ${opt} in
    h )
      usage
      exit 0
      ;;
    e )
      input="$OPTARG"
      ;;
    d )
      input="$2"
      with_instructions=true
      ;;
    \? )
      usage
      exit 1
      ;;
  esac
done

shift $((OPTIND -1))

# Check if input is empty
if [ -z "$input" ]; then
  input=$(cat "${1:-/dev/stdin}")
fi

# Encode the input text
encoded=$(echo "$input" | gzip -cf | base64)

# Print the encoded text and decoding instructions separately
if [ "$with_instructions" = true ]; then
  # Print the decoding instructions
  echo "To decode the message, run the following command:"
  echo "echo '$encoded' | base64 -d | gunzip"

  # Print the encoded text
  echo ""
  echo "Encoded message:"
  echo "$encoded"
else
  # Print only the encoded text
  echo "$encoded"
fi
