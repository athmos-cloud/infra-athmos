
locals {
  address_suffix = var.format == "DOCKER" ? "docker-registry" : "eu.artifacts"
}

output "registry_url" {
    value = "${var.region}-${var.name}.pkg.dev/${var.project}/${local.address_suffix}"
}