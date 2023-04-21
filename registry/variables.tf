
variable "project" {
  description = "Name of the project"
  type = string
  required = true
}

variable "location" {
  description = "Location of the registry [EU, US, ASIA]"
  type = string
  default = "EU"
}

variable "viewers" {
  description = "List of the service accounts that will have viewer access to the registry [ex: user:jane@example.com]"
  type = list(string)
}

variable "admins" {
  description = "List of the service accounts that will have admin access to the registry [ex: user:jane@example.com]"
  type = list(string)
}