terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.62.1"
    }
    github = {
      source = "integrations/github"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
}

provider "github" {
  owner = var.github_owner
  token = var.github_token
}