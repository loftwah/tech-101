# A Guide to Setting Up a VPC with Public and Private Subnets

[VPC with public and private subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html)

This guide will walk you through the process of setting up a Virtual Private Cloud (VPC) with public and private subnets using Terraform. This scenario is similar to scenario 2 from the AWS official documentation.

## Setting Up a VPC

In this exercise, we will create a VPC with public and private subnets. The public subnets will allow inbound and outbound internet traffic, while the private subnets will only allow outbound internet traffic through a NAT gateway.

### Terraform Configuration

Here's an example of how to set up a VPC with public and private subnets using Terraform:

```hcl
resource "aws_vpc" "example" {
cidr_block = "10.0.0.0/16"

tags = {
Name = "example-vpc"
}
}

resource "aws_subnet" "public" {
count = 2

cidr_block = "10.0.${count.index + 1}.0/24"
vpc_id = aws_vpc.example.id

tags = {
Name = "example-public-${count.index + 1}"
}

map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
count = 2

cidr_block = "10.0.${100 + count.index + 1}.0/24"
vpc_id = aws_vpc.example.id

tags = {
Name = "example-private-${count.index + 1}"
}
}

resource "aws_nat_gateway" "example" {
count = 2

subnet_id = aws_subnet.public[count.index].id

allocation_id = aws_eip.example[count.index].id
}

resource "aws_eip" "example" {
count = 2
}
```

In this example, we are creating a VPC with the CIDR block `10.0.0.0/16`. The VPC will have two public subnets and two private subnets, each with a /24 CIDR block. The public subnets will allow inbound and outbound internet traffic, while the private subnets will only allow outbound internet traffic through a NAT gateway.

## Explanation of Terraform Configuration

- The `aws_vpc` resource creates a VPC with the specified CIDR block and tags.

- The `aws_subnet` resource creates subnets within the VPC. The `count` argument is used to create two public subnets and two private subnets.

- The `map_public_ip_on_launch` argument is set to `true` for the public subnets, which allows instances in these subnets to have public IP addresses.

- The `aws_nat_gateway` resource creates NAT gateways for the private subnets, allowing outbound internet traffic. The `allocation_id` argument is set to an Elastic IP address created with the `aws_eip` resource.

## Next Steps

- The `aws_nat_gateway` resource creates NAT gateways for the private subnets, allowing outbound internet traffic. The `allocation_id` argument is set to an Elastic IP address created with the `aws_eip` resource.

Now that you have set up a VPC with public and private subnets, you can move on to the next exercise. In the next exercise, you will learn how to create an EC2 instance within the VPC and configure security groups and routing tables.

[//]: # (End of file drills/6-create-vpc-public-private/README.md)
