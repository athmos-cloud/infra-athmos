
resource "google_container_registry" "registry" {
    project = var.project
    location = var.location
}

resource "google_storage_bucket_iam_member" "viewer" {
    for_each = to_set(var.viewers)
    bucket = google_container_registry.registry.id
    role = "roles/storage.objectViewer"
    member = each.key
  
}

resource "google_storage_bucket_iam_member" "admin" {
    for_each = to_set(var.admins)
    bucket = google_container_registry.registry.id
    role = "roles/storage.objectEditor"
    member = each.key
}