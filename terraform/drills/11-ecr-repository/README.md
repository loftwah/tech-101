# A Guide to Setting Up an ECR Repository

This guide will walk you through the process of setting up an ECR repository for your Ruby on Rails 6 application. It will show you how to create an ECR repository, store a Docker image of your application in the repository, and push updates to the image.

## Prerequisites

Before you start, you should have the following:

* An AWS account
* A Ruby on Rails 6 application
* Docker installed on your development machine

## Creating an ECR Repository

1. Log in to the AWS Management Console.
2. Go to the Amazon ECR service.
3. Click the "Create repository" button.
4. Enter a name for your repository, such as "example-rails-app".
5. Click the "Create repository" button to create the repository.

## Storing a Docker Image in the Repository

1. Build a Docker image of your Ruby on Rails 6 application.
2. Tag the image with the URL of the ECR repository. For example:

```bash
docker tag example-rails-app:latest 123456789012.dkr.ecr.ap-southeast-2.amazonaws.com/example-rails-app:latest
```

1. Push the image to the ECR repository.

```bash
docker push 123456789012.dkr.ecr.ap-southeast-2.amazonaws.com/example-rails-app:latest
```

## Updating the Docker Image

1. Make changes to your Ruby on Rails 6 application.
2. Build a new Docker image of your application.
3. Tag the new image with the URL of the ECR repository. For example:

```bash
docker tag example-rails-app:latest 123456789012.dkr.ecr.ap-southeast-2.amazonaws.com/example-rails-app:latest
```

1. Push the new image to the ECR repository.

```bash
docker push 123456789012.dkr.ecr.ap-southeast-2.amazonaws.com/example-rails-app:latest
```

## Next Steps

Now that you have set up an ECR repository for your Ruby on Rails 6 application, you can move on to the next exercise. In the next exercise, you will learn how to deploy your application to AWS ECS using the Docker image stored in the ECR repository.

[//]: # (End of file drills/11-ecr-repository/README.md)
