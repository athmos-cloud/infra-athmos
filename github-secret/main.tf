
resource "github_repository" "repo" {
  name = var.repo
}

resource "github_actions_secret" "secret" {
  repository      = github_repository.repo.name
  secret_name     = var.secret_name
  plaintext_value = var.secret_value
}
