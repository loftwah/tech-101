#!/bin/bash

INPUT_FILE=$1

if [[ ! -f $INPUT_FILE ]]; then
    echo "Input file not found!"
    exit 1
fi

# Remove file extension
BASE_NAME=$(basename $INPUT_FILE .txt)

# Split file into parts of 7500 characters
split -C 7500 --numeric-suffixes=1 --suffix-length=3 --additional-suffix=.txt $INPUT_FILE ${BASE_NAME}_
