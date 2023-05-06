resource "google_compute_subnetwork" "subnetwork" {
  name          = var.name
  ip_cidr_range = var.ip_cidr_range  #"10.2.0.0/16"
  region        = var.region
  network       = var.network_id

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges
    content {
        range_name    = secondary_ip_range.value.range_name
        ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }  
}

# secondary_ip_range {
# range_name    = "services-range"
# ip_cidr_range = "192.168.1.0/24"
# }

# secondary_ip_range {
#     range_name    = "pod-ranges"
#     ip_cidr_range = "192.168.64.0/22"
# }