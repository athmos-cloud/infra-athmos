
module "main_network" {
    source = "./network"
    name = "main-network"
}

module "artifact_subnet" {
    source = "./subnetwork"
    name = "artifact-subnet"
    network_id = module.main_network.network_id
    region = var.region
    ip_cidr_range = "10.155.0.0/27"
}

module "athmos_gke_subnet" {
    source = "./subnetwork"
    name = "athmos-subnet"
    region = var.region
    network_id = module.main_network.network_id
    ip_cidr_range = "10.156.0.0/16"
    secondary_ip_ranges = [ {
        range_name = "services-range"
        ip_cidr_range = "10.12.0.0/24"
    }, {
        range_name = "pod-ranges"
        ip_cidr_range = "10.12.4.0/22"
    }]
}

module "plugins_gke_subnet" {
    source = "./subnetwork"
    name = "plugins-subnet"
    network_id = module.main_network.network_id
    region = var.region
    ip_cidr_range = "10.0.0.0/22"
    secondary_ip_ranges = [ {
        range_name = "services-range"
        ip_cidr_range = "10.1.0.0/25"
    }, {
        range_name = "pod-ranges"
        ip_cidr_range = "10.2.0.0/24"
    }]
}

# Container Registry

module "docker_registry_sa_admin" {
    source = "./service-account"
    project = var.project
    id = "docker-registry-admin"
    name = "Admin Service Account for Docker Registry"
}

module "docker_registry_sa_viewer" {
    source = "./service-account"
    project = var.project
    id = "docker-registry-viewer"
    name = "Viewer Service Account for Docker Registry"
}

module "docker_registry" {
    source = "./registry"
    name = "docker-registry"
    description = "Docker Registry"
    project = var.project
    format = "DOCKER"
    region = var.region
    admins_sa = [ module.docker_registry_sa_admin.email ]
    viewers_sa = [ module.docker_registry_sa_viewer.email ]
}

resource "github_actions_secret" "secret" {
  repository      = "athmos-cloud/app-athmos"
  secret_name     = "DOCKER_PASSWORD"
  plaintext_value = module.docker_registry_sa_admin.private_key
}
