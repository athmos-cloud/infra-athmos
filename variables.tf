
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

variable "github_organization" {
  description = "Github organization"
  default = "athmos-cloud"
  type = string
}

variable "config_local_dir" {
  description = "The directory where the local configuration files will be stored"
  default = "/home/paulb/.config/athmos/infra"
  type = string
}