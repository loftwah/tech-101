#!/bin/bash

# Fetch all bucket names
buckets=$(aws s3 ls --region ap-southeast-2 | awk '{print $3}')

# Loop through each bucket and calculate size
for bucket in $buckets
do
  echo -n "Calculating size for bucket: $bucket ... "
  
  # Run the aws command with a 20-second timeout
  total_size=$(timeout 20 aws s3 ls s3://$bucket --recursive --summarize --region ap-southeast-2 | awk 'BEGIN {total=0} {total+=$3} END {printf total}')
  
  timeout_occurred=$?
  
  # Check if a timeout occurred
  if [[ $timeout_occurred -eq 124 ]]; then
    echo -n "(Timed out) "
  fi
  
  # Make the size human-readable
  if [[ $total_size -ge 1099511627776 ]]; then
    echo $((total_size/1099511627776))" TB"
  elif [[ $total_size -ge 1073741824 ]]; then
    echo $((total_size/1073741824))" GB"
  elif [[ $total_size -ge 1048576 ]]; then
    echo $((total_size/1048576))" MB"
  elif [[ $total_size -ge 1024 ]]; then
    echo $((total_size/1024))" KB"
  else
    echo $total_size" bytes"
  fi
done
