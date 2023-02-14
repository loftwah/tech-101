# Creating an S3 Bucket with Terraform

This guide will walk you through the process of creating an Amazon S3 bucket using Terraform. You will learn how to write Terraform code to create an S3 bucket, and how to use Terraform commands to apply the changes.

## Requirements

* Terraform installed on your local machine
* AWS account with necessary permissions to create an S3 bucket

## Terraform Commands

The following Terraform commands will be used in this exercise:

* Load required modules and resources: `terraform init`
* Preview changes: `terraform plan`
* Apply changes (prompts for confirmation): `terraform apply`
* Destroy resources managed by Terraform in this directory: `terraform destroy`

## Task 1: Creating an S3 Bucket with Private Access

In this task, you will create an S3 bucket with private access using Terraform. The following steps will guide you through the process:

1. Create a new directory for your Terraform code.
2. In the new directory, create a file named `main.tf`. This file will contain the Terraform code for creating the S3 bucket.
3. Write the Terraform code for creating an S3 bucket with private access. You can use the following code as a reference:

```hcl
resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"
  acl    = "private"
}
```

1. Save the file.
2. In the terminal, navigate to the directory where the Terraform code is stored.
3. Run the `terraform init` command to load required modules and resources.
4. Run the `terraform plan` command to preview the changes that will be made.
5. If the preview looks correct, run the `terraform apply` command and confirm the changes.
6. Verify that the S3 bucket has been created in the AWS Management Console.

## Task 2: Adding Tags to the S3 Bucket

In this task, you will add tags to the S3 bucket created in Task 1. The following steps will guide you through the process:

```hcl
1.  Open the `main.tf` file.
2.  Add the following code to add tags to the S3 bucket:

resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"
  acl    = "private"

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Dev"
  }
}
```

1. Save the file.
2. Run the `terraform plan` command to preview the changes that will be made.
3. If the preview looks correct, run the `terraform apply` command and confirm the changes.
4. Verify that the tags have been added to the S3 bucket in the AWS Management Console.

## Task 3: Configuring Static Website Hosting

In this task, you will configure static website hosting for the S3 bucket created in Task 1. The following steps will guide you through the process:

1. Open the `main.tf` file.
2. Add the following code to configure static website hosting for the S3 bucket:

```hcl
resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```

3. Save the file.
4. Run the `terraform plan` command to preview the changes that will be made.
5. If the preview looks correct, run the `terraform apply` command and confirm the changes.
6. Verify that the S3 bucket has been configured for static website hosting in the AWS Management Console.

## Task 4: Configuring CORS

In this task, you will configure cross-origin resource sharing (CORS) for the S3 bucket created in Task 1. The following steps will guide you through the process:

1. Open the `main.tf` file.
2. Add the following code to configure CORS for the S3 bucket:

```hcl
resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://example.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
```

1. Save the file.
2. Run the `terraform plan` command to preview the changes that will be made.
3. If the preview looks correct, run the `terraform apply` command and confirm the changes.
4. Verify that CORS has been configured for the S3 bucket in the AWS Management Console.

## Task 5: Enabling Versioning

In this task, you will enable versioning for the S3 bucket created in Task 1. The following steps will guide you through the process:

1. Open the `main.tf` file.
2. Add the following code to enable versioning for the S3 bucket:

```hcl
resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
```

1. Save the file.
2. Run the `terraform plan` command to preview the changes that will be made.
3. If the preview looks correct, run the `terraform apply` command and confirm the changes.
4. Verify that versioning has been enabled for the S3 bucket in the AWS Management Console.

## Task 6: Enabling Logging

In this task, you will enable logging for the S3 bucket created in Task 1. The following steps will guide you through the process:

1. Open the `main.tf` file.
2. Add the following code to create a separate S3 bucket for logging:

```hcl
resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}
```

3. Save the file.
4. Run the `terraform plan` command to preview the changes that will be made.
5. If the preview looks correct, run the `terraform apply` command and confirm the changes.
6. Verify that logging has been enabled for the S3 bucket in the AWS Management Console.

## Task 7: Configuring Object Lifecycle

In this task, you will configure the object lifecycle for the S3 bucket created in Task 1. The following steps will guide you through the process:

1. Open the `main.tf` file.
2. Add the following code to configure the object lifecycle for the S3 bucket:

```hcl
resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"
  acl    = "private"

  lifecycle_rule {
    id      = "log"
    enabled = true

    prefix = "log/"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
}
```

1. Save the file.
2. Run the `terraform plan` command to preview the changes that will be made.
3. If the preview looks correct, run the `terraform apply` command and confirm the changes.
4. Verify that the object lifecycle has been configured for the S3 bucket in the AWS Management Console.

## Task 8: Configuring Object Lock

In this task, you will configure object lock for the S3 bucket created in Task 1. The following steps will guide you through the process:

1. Open the `main.tf` file.
2. Add the following code to configure object lock for the S3 bucket:

```hcl
resource "aws_s3_bucket" "b" {
  bucket = "my-s3-bucket"

  object_lock_configuration {
    object_lock_enabled = "Enabled"

    rule {
      default_retention {
        mode = "COMPLIANCE"
        days = 5
      }
    }
  }
}
```

1. Save the file.
2. Run the `terraform plan` command to preview the changes that will be made.
3. If the preview looks correct, run the `terraform apply` command and confirm the changes.
4. Verify that object lock has been configured for the S3 bucket in the AWS Management Console.

With these tasks, you should now have a good understanding of how to create an S3 bucket using Terraform and configure various options for it.

[//]: # (End of file drills/3-create-s3-bucket/README.md)
