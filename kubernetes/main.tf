resource "google_container_cluster" "my_vpc_native_cluster" {
  name               = var.name
  location           = var.region
  initial_node_count = var.initial_node_count

  network    = var.network_id
  subnetwork = var.subnetwork_id

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_ranges
    services_secondary_range_name = var.services_range
  }

  # other settings...
}

resource "google_container_node_pool" "linux_pool" {
  name               = "linux-pool"
  project            = google_container_cluster.demo_cluster.project
  cluster            = google_container_cluster.demo_cluster.name
  location           = google_container_cluster.demo_cluster.location

  initial_node_count = var.initial_node_count # 1

  node_config {
    image_type   = var.image_type # "COS_CONTAINERD"
    machine_type = var.machine_type # "e2-standard-4"
    disk_size_gb = var.disk_size_gb # 100
  }

  autoscaling {
    min_node_count = var.min_node_count # 1
    max_node_count = var.max_node_count # 3
  }
}