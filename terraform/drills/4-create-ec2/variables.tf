variable "public_key_path" {
  description = "The path to your public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "The path to your private key file"
  type        = string
  default     = "~/.ssh/id_rsa"
}