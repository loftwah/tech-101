# Terraform 101

[drills](drills/README.md) | [test](test/test.md)

Welcome to our Terraform Bootcamp!

![Terraform 101](https://user-images.githubusercontent.com/19922556/219302916-57002f7c-a51f-4d0c-a70a-884e2c9cbc24.jpg)

In this course, you will learn how to use Terraform to manage your cloud infrastructure as code, specifically on AWS, which is a platform used by team. Terraform is a powerful tool developed by HashiCorp that makes it easy to create, change, and version resources in cloud platforms such as AWS.

By using Terraform, you can define your infrastructure in human-readable configuration files and automate the process of provisioning and managing your resources. This means you can focus on your application, instead of worrying about the underlying infrastructure.

In this bootcamp, we will specifically focus on AWS and show you how to use Terraform to deploy resources such as Virtual Private Clouds (VPCs), security groups, and virtual machines in AWS. You will also learn how to use Terraform to manage your infrastructure throughout its lifecycle and collaborate with other members of your team using Terraform Cloud.

So, buckle up and let's get started with Terraform at team!

## Course Prerequisites

To get the most out of this course, you should have a basic understanding of the following concepts:

* The AWS platform
* The Linux command line

## Course Requirements

To complete this course, you will need the following:

* A computer with an internet connection
* A free AWS account
* Terraform installed on your computer
* A text editor such as Visual Studio Code or Vim

## Get Started

What are you waiting for? Jump right into the [drills](drills/README.md) and start learning Terraform! Or you could read the [intro](intro.md) to learn more about Terraform.

## Course Resources

* [Terraform Documentation](https://www.terraform.io/docs/index.html)
* [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Terraform Cloud Documentation](https://www.terraform.io/docs/cloud/index.html)
* [Terraform Cloud Free Tier](https://www.terraform.io/docs/cloud/free/index.html)
* [Terraform Cloud Free Tier Signup](https://app.terraform.io/signup/account)

## Terraform 101: An Introduction to Managing Infrastructure with Code

Terraform is an open-source infrastructure as code (IAC) tool developed and maintained by HashiCorp. It allows you to define and manage your infrastructure as code, meaning that you can write code that describes the desired state of your infrastructure resources, such as virtual machines, containers, databases, and more.

This approach to infrastructure management provides several benefits, including:

Version control: Because your infrastructure is defined as code, you can track changes and revert to previous versions if necessary, just as you would with application code.

Collaboration: By using version control, you can work collaboratively with other developers and infrastructure teams. Changes can be reviewed and approved before being merged, ensuring that everyone is working from the same codebase.

Reusability: Terraform allows you to define your infrastructure in reusable modules, making it easy to deploy similar resources across multiple environments.

Automation: By defining your infrastructure as code, you can automate the process of provisioning and managing resources, reducing the risk of manual errors.

Terraform is vendor-agnostic and can be used to manage resources in various cloud environments, including AWS, Azure, Google Cloud Platform, and more. It also supports on-premises infrastructure and can manage resources in other types of infrastructure providers, such as DNS providers and monitoring services.

Terraform uses a declarative syntax to define infrastructure resources. You write code that describes the desired state of your infrastructure, and Terraform takes care of the details of provisioning and managing those resources.

Here's an example of what a Terraform configuration might look like:

```hcl
provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "example-instance"
  }
}
```

This configuration defines an AWS provider and an EC2 instance resource. The provider block specifies the AWS region to use, and the resource block specifies the attributes of the EC2 instance to create, such as the AMI ID, instance type, and tags.

Once you've written your configuration, you can use the terraform command-line tool to apply it. Terraform will analyze your configuration and compare it to the current state of your infrastructure. If there are any differences, it will create, modify, or destroy resources as necessary to bring your infrastructure into the desired state.

For example, if you run terraform apply on the configuration above, Terraform will create a new EC2 instance in the specified region, using the specified AMI ID, instance type, and tags.

Terraform also provides a rich ecosystem of modules, plugins, and providers that extend its functionality. Modules are pre-built configurations that you can use to deploy common patterns of infrastructure, such as load balancers or databases. Plugins and providers allow Terraform to integrate with other services and providers, such as GitHub or Docker.

In summary, Terraform is a powerful infrastructure as code tool that allows you to define, manage, and automate your infrastructure resources. It provides benefits such as version control, collaboration, reusability, and automation, and is vendor-agnostic, meaning you can use it to manage resources in various cloud and on-premises environments.
