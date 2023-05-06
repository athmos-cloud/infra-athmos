
variable "project" {
  description = "GCP proect in which the infratructure will be provisioned"
  type = string
}

variable "id" {
  description = "ID of the service account"
  type = string
}

variable "name" {
  description = "Display ame of the service account"
  type = string
}
