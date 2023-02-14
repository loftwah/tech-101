variable "file_content" {
    description = "The content of a file we'll be generating"
    type        = string
    default     = "This is what I'll write unless you tell me to write something else."
}

variable "file_extension" {
    description = "The extension for a file we'll be generating"
    type        = string
    default     = "xyz"
}

variable "random_string_length" {
    description = "The numerical value for the length of the random string"
    type        = number
    default     = 6
}