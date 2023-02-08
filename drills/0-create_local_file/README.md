# A Guide to Terraform Basics

This guide will walk you through the basics of Terraform. It will show you how to create a local file using Terraform. It will also show you how to use the four most common Terraform commands.

## Creating a Local File

In this exercise, we will create a file named `ignoreMe.something` with some arbitrary text. The file will be stored in the current directory. This will give us an opportunity to run four commonly used Terraform commands.

### Terraform Commands for this Directory Only

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

This command destroys everything managed by Terraform in the current directory. In this example, it will delete the file `ignoreMe.something`.

## Updating the File

To change the content of the file to "Show us the Dim Mak!", follow these steps:

1. Open the file `ignoreMe.something` and review its content.
2. Open `main.tf` and change the `content` tag to `"Show us the Dim Mak!"`.
3. Run `terraform plan` to preview the change.
4. Run `terraform apply` and confirm with "yes".
5. Open `ignoreMe.something` and check its new content.

## Destroying the File

To destroy the file, follow these steps:

1. Run `terraform destroy` and confirm with "yes".
2. Open `ignoreMe.something` and confirm that it is gone.

## Next Steps

Now that you have created a local file, you can move on to the next exercise. In the next exercise, you will create a local file with a random name.

[//]: # (End of file drills/0-create_local_file/README.md)