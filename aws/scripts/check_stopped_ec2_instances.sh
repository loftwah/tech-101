#!/bin/bash

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
  echo "AWS CLI is not installed. Please install it first."
  exit 1
fi

# Declare an array for AWS regions to check
declare -a regions=("ap-southeast-2" "us-west-1" "eu-west-1")

# Loop through each region to find stopped EC2 instances
for region in "${regions[@]}"; do
  echo "---------------------------------------------------------------"
  echo "Listing stopped EC2 instances in region: $region"

  # Use AWS CLI to list all EC2 instances that are in the 'stopped' state
  aws ec2 describe-instances \
    --region $region \
    --filters "Name=instance-state-name,Values=stopped" \
    --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,Tags[?Key==`Name`]|[0].Value,PrivateIpAddress,PublicIpAddress]' \
    --output text | \
    awk 'BEGIN { printf "%-25s %-20s %-40s %-20s %-20s\n", "InstanceID", "InstanceType", "Name", "PrivateIP", "PublicIP" } 
         { if ($4 !~ /^([0-9]{1,3}\.){3}[0-9]{1,3}$/) $4 = "-"; if ($5 !~ /^([0-9]{1,3}\.){3}[0-9]{1,3}$/) $5 = "-"; printf "%-25s %-20s %-40s %-20s %-20s\n", $1, $2, $3, $4, $5 }'
done
