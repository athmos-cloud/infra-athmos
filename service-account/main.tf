
resource "google_service_account" "sa" {
    project = var.project
    account_id = var.id
    display_name = var.name
}

resource "google_service_account_key" "sa_key"{
    service_account_id = google_service_account.sa.name
    public_key_type = "TYPE_X509_PEM_FILE"
      key_algorithm      = "KEY_ALG_RSA_2048"
}

