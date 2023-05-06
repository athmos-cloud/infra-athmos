
resource "google_artifact_registry_repository" "repository" {
  location      = var.region
  repository_id = var.name
  description   = var.description
  format        =  var.format
}


# data "google_project" "project" {
#     project_id = var.project
# }

# resource "google_storage_bucket_iam_member" "viewer" {
#     for_each = toset(var.viewer_emails)
#     bucket = google_container_registry.registry.id
#     role = "roles/storage.objectViewer"
#     member = "serviceAccount:${each.key}"
# }

# resource "google_storage_bucket_iam_member" "admin" {
#     for_each = toset(var.admin_emails)
#     bucket = google_container_registry.registry.id
#     role = "roles/storage.objectEditor"
#     member = "serviceAccount:${each.key}"
# }

resource "google_artifact_registry_repository_iam_binding" "admin_binding" {
  project = google_artifact_registry_repository.repository.project
  location = google_artifact_registry_repository.repository.location
  repository = google_artifact_registry_repository.repository.name
  role = "roles/artifactregistry.admin"
  members = [for email in var.admins_sa : "serviceAccount:${email}"]
}

resource "google_artifact_registry_repository_iam_binding" "reader_binding" {
  project = google_artifact_registry_repository.repository.project
  location = google_artifact_registry_repository.repository.location
  repository = google_artifact_registry_repository.repository.name
  role = "roles/artifactregistry.reader"
  members = [for email in var.viewers_sa : "serviceAccount:${email}"]
}