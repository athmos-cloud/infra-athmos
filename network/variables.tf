variable "name" {
  description = "Name of the network"
  type        = string
}

variable "subnet_auto_create" {
  description = "Should auto create subnets"
  type        = bool
  default     = false
}
