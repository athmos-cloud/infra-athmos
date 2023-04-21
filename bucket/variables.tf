variable "bucket" {
  type = string
  Description = "The name of our bucket"

}

variable "bucket_location" {

  type = string

  default = "us-east1"

}

variable "project_id" {

  type = string

}

variable "storage_class" {

  type = string

}