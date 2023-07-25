#!/bin/bash

REGIONS=("ap-southeast-2" "us-west-1" "eu-west-1" "us-east-1")
PROFILE=${1:-"default"}  # Default to "default" if no argument is provided
OUTPUT_FILE=${2:-"aws_resources.txt"}  # Default to "aws_resources.txt" if no argument is provided

# Clear the output file at the start
echo "" > $OUTPUT_FILE

for region in "${REGIONS[@]}"; do
    echo "Region: $region" | tee -a $OUTPUT_FILE

    echo "EC2 instances:" | tee -a $OUTPUT_FILE
    aws ec2 describe-instances --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "S3 buckets:" | tee -a $OUTPUT_FILE
    aws s3api list-buckets --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "ECS clusters:" | tee -a $OUTPUT_FILE
    aws ecs list-clusters --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "ECR repositories:" | tee -a $OUTPUT_FILE
    aws ecr describe-repositories --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "SNS topics:" | tee -a $OUTPUT_FILE
    aws sns list-topics --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "SQS queues:" | tee -a $OUTPUT_FILE
    aws sqs list-queues --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "RDS instances:" | tee -a $OUTPUT_FILE
    aws rds describe-db-instances --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "ElastiCache clusters:" | tee -a $OUTPUT_FILE
    aws elasticache describe-cache-clusters --region $region --profile $PROFILE >> $OUTPUT_FILE

    echo "SES identities:" | tee -a $OUTPUT_FILE
    aws ses list-identities --region $region --profile $PROFILE >> $OUTPUT_FILE
done
