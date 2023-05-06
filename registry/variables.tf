
variable "description" {
  description = "Description of the registry"
  type        = string
}

variable "name" {
  description = "Name of the registry"
  type        = string
}

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "region" {
  description = "Location of the registry [EU, US, ASIA]"
  type        = string
  default     = "europe-west9"
}

variable "viewers_sa" {
  description = "List of the service accounts that will have viewer access to the registry [ex: user:jane@example.com]"
  type        = list(string)
}

variable "admins_sa" {
  description = "List of the service accounts that will have admin access to the registry [ex: user:jane@example.com]"
  type        = list(string)
}

variable "format" {
  description = "Format of the registry [DOCKER, OCI]"
  type        = string
  default     = "DOCKER"
  validation {
    condition     = contains(["DOCKER", "OCI"], var.format)
    error_message = "Must be either \"DOCKER\" or \"OCI\"."
  }
}
