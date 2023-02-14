# A Guide to Creating a PostgreSQL RDS Database

This guide will walk you through the process of creating a PostgreSQL RDS database using Terraform.

## Creating a PostgreSQL RDS Database

In this exercise, we will create a PostgreSQL RDS database with a single instance.

### Terraform Configuration

Here's an example of how to create a PostgreSQL RDS database using Terraform:

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

In this example, we are creating a PostgreSQL RDS database with a single instance of type `db.t2.micro`, the name `example-postgresql-db`, and a user with the username `example_user` and password `example_password`. The database is associated with a security group that allows inbound traffic on port 5432 from any IP address (`0.0.0.0/0`).

## Explanation of Terraform Configuration

- The `aws_db_instance` resource creates an RDS database instance with the specified engine, instance class, name, username, and password.

- The `vpc_security_group_ids` argument is set to the ID of the security group created with the `aws_security_group` resource.

- The `aws_security_group` resource creates a security group with a single ingress rule that allows inbound traffic on port 5432 from any IP address.

- The `tags` argument is used to add a tag with the name "example-postgresql-db" to the database instance.

## Next Steps

Now that you have created a PostgreSQL RDS database, you can move on to the next exercise. In the next exercise, you will learn how to create an EC2 instance within the VPC and configure it to access the RDS database.

[//]: # (End of file drills/9-rds-postgres-db/README.md)