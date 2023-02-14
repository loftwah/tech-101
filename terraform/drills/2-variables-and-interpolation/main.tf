resource "local_file" "stoopid_file1" {
  # this references the variable in variables.tf  
  content  = var.file_content

  # this references the built-in path.module value and a variable
  # variables.tf. We interpolate using the ${} syntax
  filename = "${path.module}/ignoreMe.${var.file_extension}"
}

resource "random_string" "random1" {
    length           = var.random_string_length
    special          = true
    override_special = "/@£$"
}

# variables that we locally create. We can have as many of these as we want
locals {
    my_local_file_content = "Some things I needed to write down."
    my_local_file_extension = "pineapples"
}

# we reference local variables like this
resource "local_file" "stoopid_file2" {
    content = local.my_local_file_content
    filename = "${path.module}/ignoreMe.${local.my_local_file_extension}"
}

# another locals block. We could have combined it with the other locals block if we wished
locals {
    my_local_random_string_length = 3 
}

resource "random_string" "random2" {

    # we reference the locally defined string length here
    length           = local.my_local_random_string_length
    special          = true
    override_special = "/@£$"
}


# Output these to console so we can view them
output "random_string1" {
    value = random_string.random1
}

output "random_string2" {
    value = random_string.random2
}