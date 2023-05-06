output "private_key" {
  value     = google_service_account_key.sa_key.private_key
  sensitive = true
}


output "email" {
  value = google_service_account.sa.email
}