
locals {
  address_domain= var.format == "DOCKER" ? "docker.pkg.dev" : "eu.artifacts"

}

output "registry_url" {
    value = "${var.region}-${local.address_domain}/${var.project}/${var.name}"
}