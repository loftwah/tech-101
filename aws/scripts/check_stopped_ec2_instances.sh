#!/bin/bash

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
  echo "AWS CLI is not installed. Please install it first."
  exit 1
fi

# Declare an array for AWS regions to check
declare -a regions=("ap-southeast-2" "us-west-1" "eu-west-1")

# Output Header
echo -e "Region\tInstanceID\tInstanceType\tName\tPrivateIP\tPublicIP\tEBS(VolumeID:Size:Type:IOPS)\tSnapshots"

# Loop through each region to find stopped EC2 instances
for region in "${regions[@]}"; do

  # Find all EC2 instances that are in the 'stopped' state
  instance_data=$(aws ec2 describe-instances \
    --region $region \
    --filters "Name=instance-state-name,Values=stopped" \
    --query 'Reservations[*].Instances[*].[InstanceId]' \
    --output text)

  # Loop through each InstanceId and fetch details
  for instance in $instance_data; do
    instance_details=$(aws ec2 describe-instances \
      --region $region \
      --instance-ids $instance \
      --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,Tags[?Key==`Name`]|[0].Value,PrivateIpAddress,PublicIpAddress]' \
      --output text | awk -v OFS="\t" '{$1=$1}1')
    
    volume_data=$(aws ec2 describe-volumes \
      --region $region \
      --filters "Name=attachment.instance-id,Values=$instance" \
      --query 'Volumes[*].[VolumeId,Size,VolumeType,Iops]' \
      --output text | awk -v OFS=":" '{$1=$1}1')

    snapshot_data=$(aws ec2 describe-snapshots \
      --region $region \
      --filters "Name=volume-id,Values=$(echo $volume_data | awk -F ":" '{print $1}')" \
      --query 'Snapshots[*].[SnapshotId]' \
      --output text)
    
    echo -e "$region\t$instance_details\t$volume_data\t$snapshot_data"
  done
done
