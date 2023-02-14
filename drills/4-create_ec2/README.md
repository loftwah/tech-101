# A Guide to Terraform and AWS EC2 Instances

This guide will walk you through the process of creating EC2 instances on AWS using Terraform. It will show you how to create an EC2 instance and configure it with Terraform. It will also show you how to use the four most common Terraform commands.

## Creating an EC2 Instance

In this exercise, we will create an EC2 instance on AWS. We will configure the instance with Terraform and then use the four common Terraform commands to manage the instance.

### Terraform Commands for this EC2 Instance

* Load required modules and resources: `terraform init`
* Preview changes: `terraform plan`
* Apply changes (prompts for confirmation): `terraform apply`
* Destroy resources managed by Terraform in this directory: `terraform destroy`

## Explanation of Terraform Commands

### `terraform init`

This command only needs to be run when first starting with Terraform or when modules or resources are changed. Running this command again will not harm anything, but it will have no effect if there are no changes.

### `terraform plan`

This command shows a preview of changes that will be made. If the Terraform logic and state are the same, it will indicate that no changes will be made.

### `terraform apply`

This command performs a `terraform plan` and then asks for confirmation before making changes. If anything other than "yes" is entered, the command will exit and make no changes.

### `terraform destroy`

This command destroys everything managed by Terraform in the current directory. In this example, it will delete the EC2 instance.

## Updating the EC2 Instance

To update the EC2 instance, follow these steps:

1. Open the Terraform configuration file.
2. Change the desired parameters (e.g. instance type, security group, etc.).
3. Run `terraform plan` to preview the change.
4. Run `terraform apply` and confirm with "yes".
5. Check the updated EC2 instance on the AWS Management Console.

## Destroying the EC2 Instance

To destroy the EC2 instance, follow these steps:

1. Run `terraform destroy` and confirm with "yes".
2. Check the AWS Management Console to confirm that the EC2 instance is gone.

## Next Steps

Now that you have created an EC2 instance with Terraform, you can move on to the next exercise. In the next exercise, you will learn how to manage multiple EC2 instances using Terraform.

[//]: # (End of file drills/4-create_ec2_instance/README.md)