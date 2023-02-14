# A Guide to Setting Up a New Organization in AWS

This guide will walk you through the process of setting up a new organization in AWS for a Ruby on Rails 6 application that runs on AWS ECS with EC2, S3, Elasticache, RDS, SNS, SQS, and EBS.

## Prerequisites

Before starting, you'll need to have the following prerequisites in place:

- An AWS account
- A GitHub repository with the code for your Ruby on Rails 6 application
- An AWS CodeBuild project to build your Docker image
- An AWS Elastic Container Registry (ECR) repository to store your Docker image

## Setting Up a New Organization in AWS

In this exercise, we will set up a new organization in AWS for a Ruby on Rails 6 application that runs on AWS ECS with EC2, S3, Elasticache, RDS, SNS, SQS, and EBS.

### Creating a VPC

Create a VPC with a public and private subnet to host your ECS instances and RDS database.

```hcl
resource "aws_vpc" "example" {
cidr_block = "10.0.0.0/16"

tags = {
Name = "example-vpc"
}
}

resource "aws_subnet" "public" {
vpc_id = aws_vpc.example.id
cidr_block = "10.0.1.0/24"
availability_zone = "ap-southeast-2a"
map_public_ip_on_launch = true

tags = {
Name = "example-public-subnet"
}
}

resource "aws_subnet" "private" {
vpc_id = aws_vpc.example.id
cidr_block = "10.0.2.0/24"
availability_zone = "ap-southeast-2b"

tags = {
Name = "example-private-subnet"
}
}
```

In this example, we are creating a VPC with the CIDR block `10.0.0.0/16` and two subnets, one public and one private. The public subnet is configured to map public IP addresses on launch, while the private subnet does not.

### Creating an ECS Cluster and EC2 Instances

Create an ECS cluster and EC2 instances to host your Docker containers.

```hcl
resource "aws_ecs_cluster" "example" {
name = "example-ecs-cluster"
}

resource "aws_instance" "example" {
ami = "ami-0c55b159cbfafe1f0"
instance_type = "t2.micro"
subnet_id = aws_subnet.public.id

tags = {
Name = "example-ec2-instance"
}
}
```

In this example, we are creating an EC2 instance of type t2.micro in the public subnet.

- Creating an Elasticache Cluster

Create an Elasticache cluster to store your application's cache.

```hcl
resource "aws_elasticache_cluster" "example" {
  cluster_id = "example-redis-cluster"
  engine     = "redis"
  node_type  = "cache.m3.medium"
  num_cache_nodes = 2

  tags = {
    Name = "example-redis-cluster"
  }
}
```

In this example, we are creating a Redis Elasticache cluster with the ID example-redis-cluster and two cache nodes of type cache.m3.medium.

Creating an RDS Database

Create an RDS database to store your application's data.

```hcl
resource "aws_db_instance" "example" {
  engine = "postgres"
  instance_class = "db.t2.micro"
  name = "example-postgresql-db"
  username = "example_user"
  password = "example_password"
  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    Name = "example-postgresql-db"
  }
}

resource "aws_security_group" "example" {
  name = "example-postgresql-db-security-group"

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

In this example, we are creating a PostgreSQL RDS database with a single instance of type db.t2.micro, the name example-postgresql-db, and a user with the username example_user and password example_password. The database is associated with a security group that allows inbound traffic on port 5432 from any IP address (0.0.0.0/0).

- Creating an S3 Bucket

Create an S3 bucket to store your application's files.

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "example-s3-bucket"

  tags = {
    Name = "example-s3-bucket"
  }
}
```

In this example, we are creating an S3 bucket with the name example-s3-bucket.

- Creating an SNS Topic and SQS Queue

Create an SNS topic and SQS queue for your application's messaging needs.

```hcl
resource "aws_sns_topic" "example" {
  name = "example-sns-topic"
  display_name = "Example SNS Topic"
}

resource "aws_sqs_queue" "example" {
  name = "example-sqs-queue"

  tags = {
    Name = "example-sqs-queue"
  }
}

resource "aws_sns_topic_subscription" "example" {
  topic_arn = aws_sns_topic.example.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.example.arn
}
```

In this example, we are creating an SNS topic with the name example-sns-topic and display name "Example SNS Topic", and an SQS queue with the name example-sqs-queue. We then subscribe the SQS queue to the SNS topic so that messages published to the topic are delivered to the queue.

- Creating an EBS Volume

Create an EBS volume to store your application's data.

```hcl
resource "aws_ebs_volume" "example" {
  availability_zone = "ap-southeast-2a"
  size = 50

  tags = {
    Name = "example-ebs-volume"
  }
}
```

In this example, we are creating an EBS volume of size 50 GB in the availability zone ap-southeast-2a.

- Next Steps

Now that you have set up a new organization in AWS, you can move on to the next exercise. In the next exercise, you will learn how to deploy your Ruby on Rails 6 application using AWS ECS and the Docker image stored in AWS ECR.

[//]: # (End of file drills/10-new-organization/README.md)
