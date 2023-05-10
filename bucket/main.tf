resource "google_storage_bucket" "bucket" {
  name = var.bucket_name
  storage_class = var.storage_class
  location = var.bucket_location
  versioning {
    enabled = var.enable_versioning
  }
}

data "google_iam_policy" "admins" {
  binding {
    role = "roles/storage.admin"
    members = [for sa in var.viewer_service_accounts : "serviceAccount:${sa}"]
  }
}

resource "google_storage_bucket_iam_policy" "policy_admins" {
  depends_on = [ resource.google_storage_bucket.bucket ]
  bucket = google_storage_bucket.bucket.name
  policy_data = data.google_iam_policy.admins.policy_data
}

data "google_iam_policy" "viewers" {
  binding {
    role = "roles/storage.objectViewer"
    members = [for sa in var.viewer_service_accounts : "serviceAccount:${sa}"]
  }
}

resource "google_storage_bucket_iam_policy" "policy_viewers" {
  depends_on = [ resource.google_storage_bucket.bucket ]
  bucket = google_storage_bucket.bucket.name
  policy_data = data.google_iam_policy.viewers.policy_data
}