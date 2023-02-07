# A warm-up with the basics

## Creates a local file

This will get us warmed up. It creates a file named `ignoreMe.something` that has some arbitrary text.
The file will be in this directory. The exercise is just to give us a chance to run the 4 frequently run
Terraform commands.

### The following commands will act ONLY on the Terraform logic in this directory

### Loads the modules & resources that the Terraform logic in this directory will need
`terraform init`

### Tells us what change will be made
`terraform plan`

### Actually makes the change. An explicit `yes` will be requested
`terraform apply`

### Destroys the things that were created by the Terraform logic in this directory.
`terraform destroy`

---

## About `terraform init`
The command only *needs* to be run either initially (before the .terraform directory existed) 
or when there is a change in modules or resources. In this exercise, we won't change these.
It does no harm to run the command again. It will just change nothing.

## About `terraform plan`
The command gives you a preview of changes to be made. If the terraform logic and the 
current `terraform state` are the same, It will indicate that no change will be made.

## About `terraform apply`
The command actually does a `terraform plan` and then prompts you for a `yes` before making changes.
If you type anything other than `yes`, it exits and makes no change.

## About `terraform destroy`
The command destroys everything that is *managed* by Terraform, meaning it destroys anything
that was created by the Terraform logic in the current directory. In this example, it will
delete the `ignoreMe.something` file in this directory.

---

## Making updates
Suppose we wanted to change the content of the file to be `Show us the Dim Mak!`

- First, open the `ignoreMe.something` and review its content.
- Next, open `main.tf` and change the `content` tag to be `"Show us the Dim Mak!"`
- Run `terraform plan`
    - It should show that a change will be made to the content of the file.
- Run `terraform apply` and respond with a `yes`
- Let's open the `ignoreMe.something` and check its new content.