#!/bin/bash

# Declare an array for AWS regions to check
declare -a regions=("ap-southeast-2" "us-west-1" "eu-west-1")

# Loop through each region to find unused Elastic IPs
for region in "${regions[@]}"; do
  echo "---------------------------------------------------------------"
  echo "Listing ONLY UNUSED Elastic IP addresses in region: $region"

  # Use AWS CLI to list all Elastic IPs that are not associated with an instance
  aws ec2 describe-addresses \
    --region $region \
    --query 'Addresses[?InstanceId==`null`].[Tags[?Key==`Name`]|[0].Value,PublicIp,AllocationId,InstanceId]' \
    --output text | \
    awk 'BEGIN { printf "UNUSED Elastic IPs\n"; printf "%-20s %-20s %-25s %-25s\n", "Name", "PublicIP", "AllocationID", "AssociatedSystemID" } 
         { printf "%-20s %-20s %-25s %-25s\n", $1, $2, $3, "NOT IN USE" }'

done
