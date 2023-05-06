
variable "project" {
  description = "GCP proect in which the infratructure will be provisioned"
  default = "athmos-378910"
  type = string
}

variable "region" {
  description = "GCP region in which the infratructure will be provisioned"
  default = "europe-west9"
  type = string
}

variable "credentials_file" {
  description = "Path to the GCP credentials file"
  default = "~/.config/gcloud/athmos.json"
  type = string
  sensitive = true
}

variable "github_token_file" {
  description = "Github personal access token"
  default = "~/.config/github/athmos"
  type = string
}

variable "github_owner" {
  description = "Github owner"
  default = "PaulBarrie"
  type = string
}