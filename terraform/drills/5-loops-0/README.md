# A Guide to Looping Over Lists in Terraform

This guide will walk you through the process of looping over lists in Terraform.
It will show you how to use the `for_each` and `count` meta-arguments in Terraform
to create multiple resources of the same type.

## Looping Over Lists with `for_each`

In this exercise, we will create multiple AWS S3 buckets using the `for_each`
meta-argument in Terraform.

### Terraform Configuration

Here's an example of how to use the `for_each` meta-argument to create multiple S3 buckets:

```hcl
resource "aws_s3_bucket" "bucket" {
for_each = {
"bucket1" = {},
"bucket2" = {},
"bucket3" = {}
}

bucket = each.key
}
```

In this example, we are creating three S3 buckets with the names that begin with:
`bucket1`, `bucket2`, and `bucket3`.
- **S3 bucket names must be unique globally. This means that your bucket name must
not already be used anywhere else in AWS. Therefore, for this exercise, we will
append either our account ID or a random guid to the name of buckets we create.**
- Now checkout the `main.tf` file to see this example.

## Looping Over Lists with `count`

In this exercise, we will create multiple EC2 instances using the `count` meta-argument in Terraform.

Here's an example of how to use the `count` meta-argument to create multiple EC2 instances:

```hcl
resource "aws_instance" "example" {
count = 3

instance_type = "t2.micro"
}
```

In this example, we are creating three EC2 instances with the type `t2.micro`.

## Looping Over Maps with `for`

In this exercise we create a list of strings from a locally defined map using the `for` meta-argument in Terraform.

Here is an example of how to use `for` to create a list of strings from a map:

```hcl
locals {
    animals = {
        "bears"  = "hibernate", # here, the key is bears and the value is hibernate
        "dogs"   = "bark",
        "horses" = "gallup"
    }

    # a list of strings
    animal_activities = [
        for animal, activity in local.animals: 
            "${animal} ${activity}"        
        ]
}
```


## Explanation of Meta-Arguments

### `for_each`

The `for_each` meta-argument allows you to loop over a map and create multiple resources of the same type, each with its own set of arguments.

### `count`

The `count` meta-argument allows you to create multiple instances of the same resource. The count argument can either be a static number or a dynamic value derived from a Terraform expression.

### `for`

The `for` meta-argument allows you to loop over a map to create another map or a list. Checkout the example in `main.tf`.

## Next Steps

Now that you have learned how to loop over lists in Terraform, you can move on to the next exercise. In the next exercise, you will learn how to use Terraform variables and outputs to manage your resources.

[//]: # (End of file drills/5-loops-0/README.md)
