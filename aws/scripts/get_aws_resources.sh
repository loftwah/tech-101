#!/bin/bash

REGIONS=("ap-southeast-2" "us-west-1" "eu-west-1" "us-east-1")
PROFILE=${1:-"default"}  # Default to "default" if no argument is provided

for region in "${REGIONS[@]}"; do
    echo "Processing region: $region"

    echo "EC2 instances:"
    aws ec2 describe-instances --query 'Reservations[].Instances[].{InstanceId:InstanceId, InstanceName:Tags[?Key==`Name`]|[0].Value, InstanceType:InstanceType, AvailabilityZone:Placement.AvailabilityZone, PublicIp:PublicIpAddress, PrivateIp:PrivateIpAddress, PublicDns:PublicDnsName, VPC:VpcId, Subnet:SubnetId, SecurityGroups:SecurityGroups[].GroupId, State:State.Name}' --output json --region $region --profile $PROFILE > "EC2_${region}.json"

    echo "S3 buckets:"
    aws s3api list-buckets --query 'Buckets[].Name' --output json --region $region --profile $PROFILE > "S3_${region}.json"

    echo "ECS clusters:"
    aws ecs list-clusters --query 'clusterArns[]' --output json --region $region --profile $PROFILE > "ECS_${region}.json"

    echo "ECR repositories:"
    aws ecr describe-repositories --query 'repositories[].repositoryName' --output json --region $region --profile $PROFILE > "ECR_${region}.json"

    echo "SNS topics:"
    aws sns list-topics --query 'Topics[].TopicArn' --output json --region $region --profile $PROFILE > "SNS_${region}.json"

    echo "SQS queues:"
    aws sqs list-queues --query 'QueueUrls[]' --output json --region $region --profile $PROFILE > "SQS_${region}.json"

    echo "RDS instances:"
    aws rds describe-db-instances --query 'DBInstances[].{DBInstanceIdentifier:DBInstanceIdentifier, DBInstanceClass:DBInstanceClass, Storage:AllocatedStorage, Subnet:DBSubnetGroup.VpcId}' --output json --region $region --profile $PROFILE > "RDS_${region}.json"

    echo "ElastiCache clusters:"
    aws elasticache describe-cache-clusters --query 'CacheClusters[].{CacheClusterId:CacheClusterId, CacheNodeType:CacheNodeType}' --output json --region $region --profile $PROFILE > "ElastiCache_${region}.json"

    echo "SES identities:"
    aws ses list-identities --query 'Identities[]' --output json --region $region --profile $PROFILE > "SES_${region}.json"

    echo "ELBv2 load balancers:"
    aws elbv2 describe-load-balancers --query 'LoadBalancers[].LoadBalancerName' --output json --region $region --profile $PROFILE > "ELBv2_${region}.json"

    echo "ELBv2 target groups:"
    aws elbv2 describe-target-groups --query 'TargetGroups[].TargetGroupName' --output json --region $region --profile $PROFILE > "TargetGroups_${region}.json"
done
