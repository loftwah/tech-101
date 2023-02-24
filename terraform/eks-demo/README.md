# Deploying a Database on Kubernetes with AWS, Ruby, Ruby on Rails, PostgreSQL, and Terraform

Kubernetes is a powerful platform for managing containerized applications, and it can also be used to manage databases. In this article, we'll explore how to deploy a database on Kubernetes using AWS, Ruby, Ruby on Rails, PostgreSQL, and Terraform.

## Prerequisites

Before we begin, make sure you have the following tools installed:

- AWS CLI: command-line tool for interacting with AWS services
- kubectl: command-line tool for interacting with Kubernetes clusters
- Terraform: infrastructure-as-code tool for provisioning and managing infrastructure

## Setting Up AWS

First, we'll need to set up an AWS account and create the necessary resources. Here are the steps:

- Create an IAM user with programmatic access and the following policies:

```bash
AmazonEC2FullAccess
AmazonRDSFullAccess
AmazonEKSFullAccess
```

- Create an EC2 key pair that you can use to SSH into your instances.
- Create an S3 bucket that we'll use to store our Terraform state.
- Create an RDS instance with the following configuration:

```bash
Database engine: PostgreSQL
DB instance class: db.t2.micro
Storage: General Purpose SSD (gp2)
Multi-AZ deployment: disabled
Publicly accessible: no
VPC security group: Create a new one and allow inbound traffic on port 5432 from the CIDR range of your Kubernetes cluster.
Create an EKS cluster with the following configuration:
Kubernetes version: 1.18
Node group: 1 node with instance type t2.small and the latest Amazon Linux 2 AMI.
IAM role: Create a new one and attach the following policies:
AmazonEKSClusterPolicy
AmazonEKSServicePolicy
AmazonEC2ContainerRegistryReadOnly
```

After you've completed the above steps, you should have an RDS instance and an EKS cluster set up in your AWS account.

## Setting Up the Project

Now that we have our AWS resources set up, let's set up the project. We'll be using Ruby on Rails to create a simple web application that connects to the PostgreSQL database.

- Create a new Ruby on Rails application:

```bash
rails new myapp --database=postgresql
cd myapp
```

- Add the aws-sdk-ec2 and aws-sdk-rds gems to your Gemfile:

```ruby
gem 'aws-sdk-ec2'
gem 'aws-sdk-rds'
```

- Install the gems:

`bundle install`

- Add the following to config/database.yml:

```yaml
production:
  adapter: postgresql
  host: <%= ENV['POSTGRES_HOST'] %>
  database: <%= ENV['POSTGRES_DB'] %>
  username: <%= ENV['POSTGRES_USER'] %>
  password: <%= ENV['POSTGRES_PASSWORD'] %>
```

- Create a new controller and view:

```bash
rails generate controller welcome index
```

- Replace the contents of app/views/welcome/index.html.erb with the following:

```ruby
<h1>Hello, World!</h1>
<p><%= @message %></p>
```

- Add the following to app/controllers/welcome_controller.rb:

```ruby
class WelcomeController < ApplicationController
  def index
    @message = "Connected to database: #{ActiveRecord::Base.connection.database_exists? ? 'yes' : 'no'}"
  end
end
```

- Create a Dockerfile at the root of your Rails application with the following contents:

```Dockerfile
FROM ruby:2.7.3-alpine3.17

RUN apk update && apk add build-base postgresql-dev nodejs yarn tzdata

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test

COPY . .

RUN SECRET_KEY_BASE=dummy RAILS_ENV=production rails assets:precompile

CMD rails server -e production -b 0.0.0.0
```

This Dockerfile installs the necessary dependencies and copies over the application code. It also precompiles the assets and starts the Rails server when the container is run.

- Build and tag the Docker image:

`docker build -t myapp .`

- Test the Docker image locally:

`docker run --rm -p 3000:3000 myapp`

- Visit <http://localhost:3000> in your web browser to confirm that the app is running correctly.
- Create a kubernetes directory in the root of your Rails application.

`mkdir kubernetes && cd kubernetes`

- Create a new Terraform configuration file named `main.tf` in the kubernetes directory with the following contents:

```terraform
provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_eks_cluster" "mycluster" {
  name     = "mycluster"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = aws_subnet.private.*.id
  }

  depends_on = [aws_iam_role_policy_attachment.eks]
}

resource "aws_iam_role" "eks" {
  name = "eks"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_eks_node_group" "mycluster" {
  cluster_name    = aws_eks_cluster.mycluster.name
  node_group_name = "mycluster"
  instance_type   = "t2.small"
  desired_capacity = 1
  ami_type        = "AL2_x86_64"
  subnet_ids      = aws_subnet.private.*.id

  depends_on = [aws_eks_cluster.mycluster]
}

resource "aws_security_group" "kubernetes" {
  name_prefix = "kubernetes-"

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = [
      aws_subnet.private.*.cidr_block,
      aws_security_group.kubernetes.id,
    ]
  }

  egress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = [
      aws_subnet.private.*.cidr_block,
      aws_security_group.kubernetes.id,
    ]
  }
}

resource "aws_subnet" "private" {
  count = 2

  cidr_block = "10.0.${count.index + 1}.0/24"
  vpc_id     = aws_vpc.kubernetes.id
}

resource "aws_vpc" "kubernetes" {
  cidr_block = "10.0.0.0/16"
}

data "aws_eks_cluster_auth" "mycluster" {
  name = aws_eks_cluster.mycluster.name
}

provider "kubernetes" {
  host = aws_eks_cluster.mycluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.mycluster.certificate_authority.0.data)
  token = data.aws_eks_cluster_auth.mycluster.token
}

resource "kubernetes_namespace" "myapp" {
  metadata {
    name = "myapp"
  }
}

resource "kubernetes_secret" "database" {
  metadata {
    name = "database"
    namespace = kubernetes_namespace.myapp.metadata.0.name
  }

  data = {
    POSTGRES_DB     = base64encode("myapp_production")
    POSTGRES_HOST   = base64encode(aws_rds_cluster_instance.mycluster.endpoint)
    POSTGRES_PASSWORD = base64encode(var.postgres_password)
    POSTGRES_USER   = base64encode(var.postgres_user)
  }
}

resource "kubernetes_resource_quota" "myapp" {
  metadata {
    name = "myapp"
    namespace = kubernetes_namespace.myapp.metadata.0.name
  }

  spec {
    hard = {
      limits.cpu = "1"
      limits.memory = "1Gi"
      requests.cpu = "1"
      requests.memory = "1Gi"
    }
  }
}
```

PostgreSQL is a stateful application, which means it maintains its own state in the form of persistent data. Running stateful applications on Kubernetes requires additional considerations and configurations.

In a typical Kubernetes deployment, pods can be easily replaced or deleted without any data loss because they are designed to be stateless. But in the case of stateful applications like databases, their state needs to persist across pod or node restarts, re-scheduling, and scaling events.

To handle stateful applications in Kubernetes, there are a few options available. One common method is to use a Kubernetes feature called StatefulSets, which provides guarantees about the ordering and uniqueness of pod names, persistent storage, and network identities for stateful applications.

StatefulSets allow you to use persistent volumes that can survive pod rescheduling or node failures. You can define the number of replicas, and each replica will have a unique hostname and a persistent identifier that is based on a headless service. This ensures that each pod receives a unique DNS name that is consistent and predictable, even if it's rescheduled to a different node.

Another option for running stateful applications on Kubernetes is to use a managed database service from your cloud provider, such as Amazon RDS or Google Cloud SQL. These services are designed to provide a highly available and scalable database, while abstracting away the underlying infrastructure and management complexities.

In summary, running stateful applications on Kubernetes requires additional configuration and considerations. Using features such as StatefulSets or a managed database service can help to ensure that your application state is persisted and available across pod and node restarts.
