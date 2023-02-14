# A Guide to Creating a Multi-Layer Ruby on Rails 6 Application on AWS ECS on EC2

This guide will walk you through the process of creating a multi-layer Ruby on Rails 6 application designed to run on AWS ECS on EC2, using Docker and Terraform. It will show you how to create the necessary components and configure them to work together, assuming you're a beginner.

## Prerequisites

Before you start, you should have the following:

* A GitHub account
* An AWS account
* A Postgres RDS database
* A Mac or Windows computer
* Docker installed on your computer
* Terraform installed on your computer

## Creating the Ruby on Rails 6 Application

1. Open a terminal window on your computer.
2. Run the following command to create a new Ruby on Rails 6 application:

```bash
rails new example-rails-app
```

1. Change to the directory containing your new Ruby on Rails 6 application:

```bash
cd example-rails-app
```

1. Configure the Ruby on Rails 6 application to use the Postgres RDS database by editing the `config/database.yml` file. You should see the following lines:

```yaml
default: &default
adapter: postgresql
encoding: unicode
pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
```

1. Add the necessary code to support Resque for scheduling and cron. You can find information on how to do this online.

## Creating the Docker Image

1. Build a Docker image of your Ruby on Rails 6 application by creating a new file named "Dockerfile" in the root directory of your Ruby on Rails 6 application. The contents of the file should be:

```Dockerfile
FROM ruby:2.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
```

1. Run the following command to build the Docker image:

```bash
docker build -t example-rails-app .
```

1. Tag the image with the URL of the ECR repository. For example:

```bash
docker tag example-rails-app:latest 123456789012.dkr.ecr.ap-southeast-2.amazonaws.com/example-rails-app:latest
```

1. Push the image to the ECR repository.

```bash
docker push 123456789012.dkr.ecr.ap-southeast-2.amazonaws.com/example-rails-app:latest
```

## Writing the Terraform Code

1. Create a new directory for your Terraform code.
2. Create a new Terraform file, such as "main.tf".
3. Write the Terraform code to create the necessary resources for your Ruby on Rails 6 application, including the ECS cluster, task definition, and service. Here is an example of what the Terraform code might look like:

```hcl
provider "aws" {
region = "ap-southeast-2"
}

resource "aws_ecs_cluster" "example-rails-app-cluster" {
name = "example-rails-app-cluster"
}

resource "aws_ecs_task_definition" "example-rails-app" {
family = "example-rails-app"
container_definitions = jsonencode([
{
name = "example-rails-app"
image = "123456789012.dkr.ecr.ap-southeast-2.amazonaws.com/example-rails-app:latest"
portMappings = [
{
containerPort = 3000
}
]
environment = [
{
name = "DATABASE_URL"
value = "postgresql://example-rails-app:password@example-rails-app.ap-southeast-2.rds.amazonaws.com:5432/example-rails-app"
}
]
}
])
}

resource "aws_ecs_service" "example-rails-app" {
name = "example-rails-app"
cluster = aws_ecs_cluster.example-rails-app-cluster.id
task_definition = aws_ecs_task_definition.example-rails-app.arn
desired_count = 1
launch_type = "EC2"
}
```

1. Write the Terraform code to create the necessary resources for your Resque for scheduling and cron, including the task definitions and services.

## Initializing and Applying the Terraform Code

1. Open a terminal window on your computer.
2. Change to the directory containing your Terraform code.
3. Run the following command to initialize Terraform:

```bash
terraform init
```

1. Run the following command to preview the changes that will be made:

```bash
terraform plan
```

1. Run the following command to apply the changes:

```bash
terraform apply
```

Enter "yes" when prompted to confirm the changes.

## Next Steps

Now that you have created a multi-layer Ruby on Rails 6 application designed to run on AWS ECS on EC2, using Docker and Terraform, and assuming you're a beginner, you can move on to testing your application. You should be able to access your Ruby on Rails 6 application by navigating to the URL of the ECS service in a web browser.

[//]: # (End of file drills/12-docker-rails-app/README.md)
