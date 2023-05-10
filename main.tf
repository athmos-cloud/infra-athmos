
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

################################################
# Container Registry
################################################

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
    region = "europe-west9"
    admins_sa = [ module.docker_registry_sa_admin.email ]
    viewers_sa = [ module.docker_registry_sa_viewer.email ]
}


# Docker actions secrets

resource "github_actions_secret" "app_docker_registry" {
  repository      = "app-athmos"
  secret_name     = "DOCKER_REGISTRY"
  plaintext_value = module.docker_registry.registry_url
}

resource "github_actions_secret" "api_docker_registry" {
  repository      = "api-athmos"
  secret_name     = "DOCKER_REGISTRY"
  plaintext_value = module.docker_registry.registry_url
}


resource "github_actions_secret" "infra_worker_docker_registry" {
  repository      = "infra-worker-athmos"
  secret_name     = "DOCKER_REGISTRY"
  plaintext_value = module.docker_registry.registry_url
}

resource "github_actions_secret" "app_docker_pwd" {
  repository      = "app-athmos"
  secret_name     = "DOCKER_PASSWORD"
  plaintext_value = module.docker_registry_sa_admin.private_key
}

resource "github_actions_secret" "api_docker_pwd" {
  repository      = "api-athmos"
  secret_name     = "DOCKER_PASSWORD"
  plaintext_value = module.docker_registry_sa_admin.private_key
}

resource "github_actions_secret" "infra_worker_docker_pwd" {
  repository      = "infra-worker-athmos"
  secret_name     = "DOCKER_PASSWORD"
  plaintext_value = module.docker_registry_sa_admin.private_key
}

resource "local_file" "docker_registry" {
  content  = module.docker_registry.registry_url
  filename = "${var.config_local_dir}/registry"
}

resource "local_file" "docker_creds" {
  content  = module.docker_registry_sa_admin.private_key
  filename = "${var.config_local_dir}/docker-creds.json"
}

################################################
# Plugins Bucket 
################################################

module "plugins_bucket_sa_admin" {
    source = "./service-account"
    project = var.project
    id = "plugins-bucket-admin"
    name = "Admin Service Account for Plugins Bucket"
}

module "plugins_bucket_sa_viewer" {
    source = "./service-account"
    project = var.project
    id = "plugins-bucket-viewer"
    name = "Viewer Service Account for Plugins Bucket"
}


module "plugins_bucket" {
    source = "./bucket"
    bucket_name = "athmos-plugins"
    bucket_location = "EU"
    project_id = var.project
    admin_service_accounts = [module.plugins_bucket_sa_admin.email]
    viewer_service_accounts = [module.plugins_bucket_sa_viewer.email]
}

resource "github_actions_secret" "plugin_bucket_sa_admin_secret" {
  repository      = "infra-worker-athmos"
  secret_name     = "PLUGIN_BUCKET_SA"
  plaintext_value = module.plugins_bucket_sa_admin.private_key
}

resource "github_actions_secret" "plugin_bucket_url_secret" {
  repository      = "infra-worker-athmos"
  secret_name     = "PLUGIN_BUCKET"
  plaintext_value = module.plugins_bucket.bucket_url
}

################################################
# Helm repository
################################################

module "helm_repository_sa_admin" {
    source = "./service-account"
    project = var.project
    id = "helm-repository-admin"
    name = "Admin Service Account for Helm Repository"
}

module "helm_repository_sa_viewer" {
    source = "./service-account"
    project = var.project
    id = "helm-repository-viewer"
    name = "Viewer Service Account for Helm Repository"
}

module "helm_registry" {
    source = "./registry"
    name = "helm-registry"
    description = "Helm Registry"
    project = var.project
    format = "DOCKER"
    region = "europe-west9"
    admins_sa = [ module.helm_repository_sa_admin.email ]
    viewers_sa = [ module.helm_repository_sa_viewer.email ]
}


resource "github_actions_secret" "helm_repository_sa_admin" {
  repository      = "infra-worker-athmos"
  secret_name     = "PLUGIN_BUCKET_SA"
  plaintext_value = module.helm_repository_sa_admin.private_key
}

resource "github_actions_secret" "helm_repository_url" {
  repository      = "infra-worker-athmos"
  secret_name     = "PLUGIN_HELM_REPOSITORY_URL"
  plaintext_value = module.helm_registry.registry_url
}

################################################
# GCP Project ID
################################################

resource "github_actions_secret" "app_gcp_project" {
  repository      = "app-athmos"
  secret_name     = "GCP_PROJECT"
  plaintext_value = var.project
}

resource "github_actions_secret" "api_gcp_project" {
  repository      = "api-athmos"
  secret_name     = "GCP_PROJECT"
  plaintext_value = var.project
}


resource "github_actions_secret" "infra_worker_gcp_project" {
  repository      = "infra-worker-athmos"
  secret_name     = "GCP_PROJECT"
  plaintext_value = var.project
}