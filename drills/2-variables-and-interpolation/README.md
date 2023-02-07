# We'll need to get be a bit more *flexible*

## Let's stop hardcoding values
So far, we've hardcoded eveything. We can make our logic flexible and portable
by using variables. This drill will do just that.

### We'll the resources we just worked with but substitute literals with variables

### Before changing, Let's run the terraform commands

```
terraform init
terraform plan
terraform approve
```

#### You should now see the 2 files created in this directory
- a file named `ignoreMe.xyz` with the content of "This is what I'll write unless you tell me to write something else.".
- a file named `ignoreMe.pineapples` with the content "Some things I needed to write down."

##### Let's talk about what happened
- in the `main.tf` file, look at the resource block `resource "local_file" "stoopid_file1"`
    - the `content` is set to `var.file_content`
    - look in the `variables.tf` file and there will be a block for `variable "file_content"` whose default
    value was written to `ignoreMe.xyz`
    - also, in `variables.tf`, the block for `variable "file_extension"` defined the file's extension to be `xyz`
- in the `main.tf` file, look at the resource block `resource "local_file" "stoopid_file2"`
    - the `content` is set to `local.mylocal_file_content` and the extension is `${local.my_local_file_extension}`
    - you should see a block for `locals` with `my_local_file_content` and `my_local_file_extension` defined
    - local variables were used to create this file.

##### So now we've seen how to use variables from `variables.tf` files and from `locals` blocks 

#### You should see 2 random string JSON blocks in the terminal
- `random_string1` will have the length of 6
- `random_string2` will have the length of 3

##### The random string lengths were defined in `variables.tf` and in a `locals` block also.

### OKAY, let's now we can change stuff.

In this directory, locate the `terraform.tfvars.example`, make a copy of it and name the copy `terraform.tfvars`

#### Next, run the terraform commands

```
terraform plan
terraform apply
```

- Was the file named `ignoreMe.xyz` replaced by a file with the extension you defined and your new content?
- Did `random_string1` display in the terminal with the length that you defined?

## CONGRATULATIONS! YOU'VE MADE YOUR LOGIC FLEXIBLE!!



