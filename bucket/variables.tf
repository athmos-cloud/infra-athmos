variable "bucket_name" {
  type = string
  description = "The name of the bucket"
}

variable "bucket_location" {
  description = "Location of the bucket [EU, US, ASIA]"
  type        = string
  default     = "EU"
  validation {
    condition     = contains(["EU", "US", "ASIA"], var.bucket_location)
    error_message = "Must be either \"EU\", \"US\" or \"ASIA\"."
  }
}

variable "storage_class" {
  description = "The storage class of the bucket"
  type = string
  default = "STANDARD"
}

variable "project_id" {
  description = "The project ID to host the bucket"
  type = string
}

variable "admin_service_accounts" {
  description = "List of the service accounts that will have admin access to the bucket"
  type = list(string)
}


variable "viewer_service_accounts" {
  description = "List of the service accounts that will have viewer access to the bucket"
  type = list(string)
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type = bool
  default = true
}