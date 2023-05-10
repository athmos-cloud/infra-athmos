terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.62.1"
    }
    github = {
      source = "integrations/github"
      version = "5.25.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
}

provider "github" {
  owner = var.github_organization
  token = trim(file(var.github_token_file), "\n")
}