# An Introduction to Terraform Modules

Terraform modules are a powerful way to encapsulate and reuse infrastructure code in a modular and scalable way. By defining reusable modules, you can abstract away complex infrastructure patterns, reduce duplication, and promote best practices in your organization.

- Create a new directory for your module and create a main.tf file inside it.
- Copy the entire contents of your original main.tf file into the new main.tf file in your module directory.
- Remove any variables that are specific to your project and move them to a variables.tf file in the module directory. You can replace the default values with null since they will be required when using the module.
- Remove any output variables that are specific to your project and move them to an outputs.tf file in the module directory.
- Remove any resource dependencies that are specific to your project and use variable instead. For example, instead of defining the aws_iam_role_policy_attachment resource for codebuild and codedeploy, you can use variable to pass in the relevant policy ARNs.
- Remove any references to resources outside of the module and use module instead. For example, instead of referencing the aws_codebuild_project resource directly, you can use module.my_module.aws_codebuild_project.
- Update any resource names to use the name_prefix variable. This allows users of the module to specify their own name prefix to avoid naming conflicts.
- Remove any provider configurations from the main.tf file and add them to the root module instead.
- Update the source attribute of the module block to point to the relative path of your module directory.

Here's what your module directory should look like after making these changes:

```bash
.
├── main.tf
├── outputs.tf
└── variables.tf
```

And here's an example of what the main.tf file in the module directory might look like:

```hcl
variable "name_prefix" {
  type        = string
  description = "The prefix to add to all resource names."
}

variable "github_oauth_token" {
  type        = string
  description = "The OAuth token to use for authenticating with GitHub."
}

variable "codebuild_policy_arn" {
  type        = string
  description = "The ARN of the policy to attach to the CodeBuild role."
}

variable "codedeploy_policy_arn" {
  type        = string
  description = "The ARN of the policy to attach to the CodeDeploy role."
}

variable "rds_database_url" {
  type        = string
  description = "The URL of the RDS database to connect to."
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy to."
}

variable "aws_access_key_id" {
  type        = string
  description = "The AWS access key ID to use for CodeBuild."
}

variable "aws_secret_access_key" {
  type        = string
  description = "The AWS secret access key to use for CodeBuild."
}

variable "codebuild_project_name" {
  type        = string
  description = "The name of the CodeBuild project."
}

variable "codedeploy_application_name" {
  type        = string
  description = "The name of the CodeDeploy application."
}

variable "codedeploy_deployment_group_name" {
  type        = string
  description = "The name of the CodeDeploy deployment group."
}

variable "ecs_cluster_name" {
  type        = string
  description = "The name of the ECS cluster."
}

variable "ecs_service_name" {
  type        = string
  description = "The name of the ECS service."
}

resource "aws_codebuild_project" "this" {
  name = "${var.name_prefix}-codebuild-project"

  service_role       = aws_iam_role.codebuild.arn
  artifacts          = { type = "NO_ARTIFACTS" }
  environment        = var.codebuild_environment
  source             = var.codebuild_source
  source_version     = var.codebuild_source_version
  secondary_sources  = var.codebuild_secondary_sources
  secondary_artifacts = var.codebuild_secondary_artifacts
}

resource "aws_codedeploy_app" "this" {
  name = "${var.name_prefix}-codedeploy-app"
}

resource "aws_codedeploy_deployment_group" "this" {
  name                  = "${var.name_prefix}-codedeploy-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy.arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }
  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
  }
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
  load_balancer_info {
    target_group_info {
      name = aws_alb_target_group.this.name
    }
  }
  deployment_group_alarms = var.codedeploy_alarms
}

resource "aws_iam_role" "codebuild" {
  name = "${var.name_prefix}-codebuild-role"

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
  policy_arn = var.codebuild_policy_arn
  role       = aws_iam_role.codebuild.name
}

resource "aws_iam_role" "codedeploy" {
  name = "${var.name_prefix}-codedeploy-role"

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
  policy_arn = var.codedeploy_policy_arn
  role       = aws_iam_role.codedeploy.name
}

module "ecs" {
  source = "./ecs"

  name_prefix     = var.name_prefix
  ecs_cluster_arn = aws_ecs_cluster.this.arn
  ecs_service_arn = aws_ecs_service.this.arn

  rds_database_url = var.rds_database_url
}

resource "aws_ecs_cluster" "this" {
  name = "${var.name_prefix}-ecs-cluster"
}

resource "aws_ecs_service" "this" {
  name            = "${var.name_prefix}-ecs-service"
  cluster         = aws_ecs_cluster.this.arn
  task_definition = module.ecs.task_definition_arn

  desired_count = 1
  deployment_controller {
    type = "ECS"
    }
  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.this.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.arn
    container_name   = module.ecs.container_name
    container_port   = module.ecs.container_port
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "this" {
  name_prefix = "${var.name_prefix}-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_alb" "this" {
  name               = "${var.name_prefix}-alb"
  load_balancer_type = "application"

  subnets          = var.subnets
  security_groups  = [aws_security_group.this.id]
  internal         = false
  idle_timeout     = 60
  http2_enabled    = true
  access_logs {
    bucket = aws_s3_bucket.access_logs.bucket
    prefix = aws_s3_bucket.access_logs.arn
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_target_group" "this" {
  name_prefix = "${var.name_prefix}-target-group"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/healthcheck"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 10
    matcher             = "200-399"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket" "access_logs" {
  bucket = "${var.name_prefix}-access-logs"
}

output "codebuild_project_arn" {
  value = aws_codebuild_project.this.arn
}

output "codedeploy_app_arn" {
  value = aws_codedeploy_app.this.arn
}

output "codedeploy_deployment_group_arn" {
  value = aws_codedeploy_deployment_group.this.arn
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.this.arn
}

output "ecs_service_arn" {
  value = aws_ecs_service.this.arn
}

output "alb_dns_name" {
  value = aws_alb.this.dns_name
}
```

You can then use this module in your project by creating a main.tf file in your project directory with the following content:

```hcl
module "my_module" {
  source = "/path/to/module/directory"

  name_prefix         = "myapp"
  github_oauth_token  = "abc123"
  codebuild_policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
  codedeploy_policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
  rds_database_url    = "postgresql://myuser:mypassword@mydb.myhost.com:5432
  subnets  = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1", "subnet-0123456789abcdef2"]
  vpc_id   = "vpc-0123456789abcdef0"
}
```

In this example, the my_module module is sourced from the /path/to/module/directory directory, and the required variables are provided. You would replace the source parameter with the actual path to the directory where you have saved the module.

You can then execute terraform init, terraform plan, and terraform apply to create the resources defined in the module. Once the resources have been created, you can use the output values to connect to your application and see it running on ECS.
