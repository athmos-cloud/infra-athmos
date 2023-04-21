resource "google_storage_bucket" "bucket" {
  name = var.bucket_name
  storage_class = var.storage_class
  location = var.bucket_location
}