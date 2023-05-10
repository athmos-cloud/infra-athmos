
resource "google_artifact_registry_repository" "repository" {
  location      = var.region
  repository_id = var.name
  description   = var.description
  format        =  var.format
  project       = var.project
}

resource "google_project_iam_member" "admin" {
  for_each = toset(var.admins_sa)
  project  = var.project
  role     = "roles/artifactregistry.admin"
  member   = "serviceAccount:${each.value}"
}

resource "google_project_iam_member" "viewer" {
  for_each = toset(var.viewers_sa)
  project  = var.project
  role     = "roles/artifactregistry.reader"
  member   = "serviceAccount:${each.value}"
}
