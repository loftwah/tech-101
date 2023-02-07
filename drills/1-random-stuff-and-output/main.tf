resource "random_uuid" "guid" {
}

resource "random_string" "random" {
    length           = 16
    special          = true
    override_special = "/@£$"
}

resource "random_password" "password" {
    length           = 16
    special          = true
    override_special = "!#$%&*()-_=+[]{}<>:?"
}


output "guid" {
    value = random_uuid.guid
}

output "random_string" {
    value = random_string.random
}

# This is important... passwords shouldn't be written to console
output "password" {
    value = random_password.password
    sensitive = true # comment/uncomment this line to test the error that shows for outputting passwords
}