# Flexible Terraform Configuration

In this lesson, you will learn how to use Terraform to make your configuration flexible and portable.

## Introduction

So far, we have hardcoded values in our Terraform configuration. In this drill, we'll make our logic flexible by using variables. This way, we can make our Terraform logic portable and reusable.

## Before making changes

Before we begin, let's run the following Terraform commands to see what resources we have created so far:`

```bash
terraform init
terraform plan
terraform apply
```

 You should now see two files created in the directory:

- A file named `ignoreMe.xyz` with the content `"This is what I'll write unless you tell me to write something else."`.
- A file named `ignoreMe.pineapples` with the content `"Some things I needed to write down."`.

## Understanding the existing code

In the `main.tf` file, look at the resource block `resource "local_file" "stoopid_file1"`:

- The `content` is set to `var.file_content`, which references the variable defined in the `variables.tf` file.
- The `filename` is set to `"${path.module}/ignoreMe.${var.file_extension}"`, which references the built-in `path.module` value and the `file_extension` variable defined in `variables.tf`.

In the `main.tf` file, look at the resource block `resource "local_file" "stoopid_file2"`:

- The `content` is set to `local.my_local_file_content`, which references a local variable defined in the `locals` block.
- The `filename` is set to `"${path.module}/ignoreMe.${local.my_local_file_extension}"`, which references the built-in `path.module` value and the `my_local_file_extension` local variable.

You should also see two random string JSON blocks in the terminal:

- `random_string1` will have a length of 6.
- `random_string2` will have a length of 3.

The random string lengths were defined in the `variables.tf` file and in a `locals` block.

## Making changes

In this directory, locate the `terraform.tfvars.example` file. Make a copy of it and name the copy `terraform.tfvars`. Then, run the following Terraform commands:``

```bash
terraform plan
terraform apply
```

 You should now see the file named `ignoreMe.xyz` replaced with a file with the extension and content you defined. The random string values should also display in the terminal with the lengths that you defined.

## Conclusion

Congratulations! You have now made your Terraform logic flexible and portable.
