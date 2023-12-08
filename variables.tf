variable "user_uuid" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "index_html_filepath" {
  description = "File path to the index.html file"
  type        = string
}

variable "error_html_filepath" {
  description = "File path to the error.html file"
  type        = string
}
