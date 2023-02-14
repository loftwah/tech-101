# A Guide to Connecting Your GitHub Repository to AWS and Deploying Your Ruby on Rails 6 Application onto ECS with AWS CodeDeploy using Terraform

This guide will walk you through the process of connecting your GitHub repository to AWS, building your Ruby on Rails 6 application, and deploying it onto ECS with AWS CodeDeploy, using Terraform. It will show you how to create the necessary components and configure them to work together.

## Prerequisites

Before you start, you should have the following:

* A GitHub account
* An AWS account
* A Ruby on Rails 6 application stored in a GitHub repository
* A Docker image of your Ruby on Rails 6 application stored in an ECR repository
* A running ECS cluster
* An RDS database
* A running EC2 instance with the CodeDeploy agent installed

## Connecting Your GitHub Repository to AWS

1. Create a new Terraform file called `github.tf` in your Terraform project.
2. Add the following code to your `github.tf` file, replacing the `OWNER`, `REPO`, and `BRANCH` variables with your GitHub repository information:

```hcl
resource "aws_codepipeline" "example-pipeline" {
name = "example-pipeline"

 artifact_store {
   location = "example-pipeline-artifacts"
   type     = "S3"
 }

 stage {
   name = "Source"

   action {
     category     = "Source"
     owner        = "ThirdParty"
     provider     = "GitHub"
     version      = "1"
     output_artifacts = ["source_output"]
     configuration = {
       Owner = "OWNER"
       Repo  = "REPO"
       Branch = "BRANCH"
       OAuthToken = var.github_oauth_token
     }
     name = "Source"
   }
 }

 stage {
   name = "Build"

   action {
     category   = "Build"
     owner      = "AWS"
     provider   = "CodeBuild"
     version    = "1"
     input_artifacts  = ["source_output"]
     output_artifacts = ["build_output"]
     configuration = {
       ProjectName = var.codebuild_project_name
     }
     name = "Build"
   }
 }

 stage {
   name = "Deploy"

   action {
     category   = "Deploy"
     owner      = "AWS"
     provider   = "CodeDeploy"
     version    = "1"
     input_artifacts  = ["build_output"]
     configuration = {
       ApplicationName = var.codedeploy_application_name
       DeploymentGroupName = var.codedeploy_deployment_group_name
     }
     name = "Deploy"
   }
 }
}
```

1. In the same Terraform project, create a new file called `variables.tf`.
2. Add the following code to your `variables.tf` file, replacing the `CODEBUILD_PROJECT_NAME`, `CODEDEPLOY_APPLICATION_NAME`, and `CODEDEPLOY_DEPLOYMENT_GROUP_NAME` variables with the appropriate names for your resources:

```hcl
variable "github_oauth_token" {
type = string
default = "your-github-oauth-token"
}

variable "codebuild_project_name" {
type = string
default = "CODEBUILD_PROJECT_NAME"
}

variable "codedeploy_application_name" {
type = string
default = "CODEDEPLOY_APPLICATION_NAME"
}

variable "codedeploy_deployment_group_name" {
type = string
default = "CODEDEPLOY_DEPLOYMENT_GROUP_NAME"
}
```

In your main.tf file, create the necessary resources for CodeDeploy and ECS. You'll need to create a CodeDeploy application and deployment group that target your ECS service and EC2 instances, as well as an ECS service and task definition. Here's a sample code block that you can modify to fit your needs:

```hcl
resource "aws_codedeploy_application" "example-application" {
  name = var.codedeploy_application_name
}

resource "aws_codedeploy_deployment_group" "example-deployment-group" {
  name = var.codedeploy_deployment_group_name
  service_role_arn = aws_iam_role.codedeploy.arn

  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  auto_rollback_configuration {
    enabled = true
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }
}

resource "aws_ecs_service" "example-service" {
  name = var.ecs_service_name
  cluster = var.ecs_cluster_name
  desired_count = var.ecs_service_desired_count
  task_definition = aws_ecs_task_definition.example-task.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.example-target-group.arn
    container_name = var.ecs_container_name
    container_port = var.ecs_container_port
  }

  depends_on = [
    aws_lb_target_group_attachment.example-target-group-attachment
  ]
}

resource "aws_ecs_task_definition" "example-task" {
  family = var.ecs_task_family

  container_definitions = jsonencode([
    {
      name = var.ecs_container_name
      image = var.ecs_container_image
      essential = true
      memory_reservation = var.ecs_container_memory_reservation
      portMappings = [
        {
          containerPort = var.ecs_container_port
        }
      ]
      environment = [
        {
          name = "DATABASE_URL"
          value = var.rds_database_url
        }
      ]
    }
  ])

  requires_compatibilities = [
    "EC2"
  ]

  network_mode = "awsvpc"
}
```

Add the necessary permissions to your IAM roles to allow CodePipeline and CodeDeploy to access your AWS resources. You'll need to create an IAM role for CodePipeline, an IAM role for CodeBuild, and an IAM role for CodeDeploy. Here's a sample code block that you can modify to fit your needs:

```hcl
resource "aws_iam_role" "codepipeline" {
  name = "example-codepipeline"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
  role = aws_iam_role.codepipeline.name
}

resource "aws_iam_role" "codebuild" {
  name = "example-codebuild"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

       Principal = {
         Service = "codebuild.amazonaws.com"
       }
     }
   ]
 })
}

resource "aws_iam_role_policy_attachment" "codebuild" {
policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
role = aws_iam_role.codebuild.name
}

resource "aws_iam_role" "codedeploy" {
name = "example-codedeploy"
assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
Action = "sts:AssumeRole"
Effect = "Allow"
Principal = {
Service = "codedeploy.amazonaws.com"
}
}
]
})
}

resource "aws_iam_role_policy_attachment" "codedeploy" {
policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
role = aws_iam_role.codedeploy.name
}
```

1. Add the necessary environment variables to your CodeBuild project to allow it to access your AWS resources. You'll need to add the `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION` environment variables to your CodeBuild project. Here's a sample code block that you can modify to fit your needs:

```hcl
resource "aws_codebuild_project" "example-project" {
name = var.codebuild_project_name
service_role = aws_iam_role.codebuild.arn
artifacts {
type = "NO_ARTIFACTS"
}
environment {
compute_type = "BUILD_GENERAL1_SMALL"
image = "aws/codebuild/standard:4.0"
environment_variable {
name = "AWS_ACCESS_KEY_ID"
value = var.aws_access_key_id
type = "PLAINTEXT"
}
environment_variable {
name = "AWS_SECRET_ACCESS_KEY"
value = var.aws_secret_access_key
type = "PLAINTEXT"
}
environment_variable {
name = "AWS_REGION"
value = var.aws_region
type = "PLAINTEXT"
}
}
}
```

1. Add the necessary variables to your Terraform project. You'll need to create a new `variables.tf` file with the following variables:

```hcl
variable "aws_access_key_id" {
type = string
default = "your-aws-access-key-id"
}

variable "aws_secret_access_key" {
type = string
default = "your-aws-secret-access-key"
}

variable "aws_region" {
type = string
default = "your-aws-region"
}

variable "github_oauth_token" {
type = string
default = "your-github-oauth-token"
}

variable "codebuild_project_name" {
type = string
default = "your-codebuild-project-name"
}

variable "codedeploy_application_name" {
type = string
default = "your-codedeploy-application-name"
}

variable "codedeploy_deployment_group_name" {
type = string
default = "your-codedeploy-deployment-group-name"
}

variable "ecs_cluster_name" {
type = string
default = "your-ecs-cluster-name"
}

variable "ecs_service_name" {
type = string
default = "your-ecs-service-name"
}

variable "ecs_service_desired_count" {
type = number
default = 1
}

variable "ecs_task_family" {
  type = string
  default = "your-ecs-task-family"
}

variable "ecs_container_name" {
  type = string
  default = "your-ecs-container-name"
}

variable "ecs_container_port" {
  type = number
  default = 3000
}

variable "ecs_container_image" {
  type = string
  default = "your-ecs-container-image"
}

variable "ecs_container_memory_reservation" {
  type = number
  default = 128
}

variable "rds_database_url" {
  type = string
  default = "your-rds-database-url"
}
```

Add the necessary output variables to your Terraform project. You'll need to create a new outputs.tf file with the following output variables:

```hcl
output "codepipeline_url" {
  value = "https://console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.example-pipeline.name}/view?region=${var.aws_region}"
}
```

Initialize your Terraform project by running terraform init in your project directory.
Apply your Terraform project by running terraform apply. Review the output and confirm that you want to apply the changes.

Once the Terraform apply has completed, you can check the status of your CodePipeline by visiting the CodePipeline URL that was outputted in the previous step.

Once the CodePipeline has successfully built and deployed your application to ECS, you can test your application by visiting the public URL of your load balancer. You can find this URL in the AWS Console by navigating to the ECS service that you created in your main.tf file and selecting the "Tasks" tab. Find the IP address of the task and paste it into your browser.

That's it! You've now created a pipeline that automatically builds and deploys your Ruby on Rails application to AWS ECS using Terraform.

[//]: # (End of file drills/13-aws-codedeploy/README.md)
