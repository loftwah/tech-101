resource "local_file" "stoopid_file" {
  content  = "Woop dee doo, I am stuff in a useless static file..."
  filename = "${path.module}/ignoreMe.something"
}