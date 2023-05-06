resource "google_compute_network" "network" {
  name                    = var.name
  auto_create_subnetworks = var.subnet_auto_create
}