#!/bin/bash

# Declare an array for AWS regions you're interested in
declare -a regions=("ap-southeast-2" "us-west-1" "eu-west-1")

# Loop through each region to find unattached volumes
for region in "${regions[@]}"; do
  echo "Checking for unattached EBS volumes in region: $region"
  
  echo -e "VolumeID\tSize\tVolumeType\tState\tCreateTime"

  aws ec2 describe-volumes \
    --region $region \
    --filters Name=status,Values=available \
    --query "Volumes[*].[VolumeId,Size,VolumeType,State,CreateTime]" \
    --output text | awk '{printf "%s\t%s\t%s\t%s\t%s\n", $1, $2, $3, $4, $5}'
  
  echo "---------------------------------------------------------------"
done
