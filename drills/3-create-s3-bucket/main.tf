resource "random_string" "random" {
    length           = 16
    special          = false
    upper            = false
}

resource "aws_s3_bucket" "bucket" {
    bucket = "autobots-terraform-${random_string.random.result}"
}

output "random_string" {
    value = random_string.random
}

output "bucket" {
    value = aws_s3_bucket.bucket
}