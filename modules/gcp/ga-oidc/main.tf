resource "google_service_account" "github_actions" {
  project      = var.project_id
  account_id   = "github-actions-sa"
  display_name = "GitHub Actions Service Account"
}

resource "google_project_iam_member" "owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_iam_workload_identity_pool" "github_actions_pool" {
  project                   = var.project_id
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = "GitHub Actions WIP"
}

resource "google_iam_workload_identity_pool_provider" "github_actions_provider" {
  project                   = var.project_id
  workload_identity_pool_id = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id

  workload_identity_pool_provider_id = "github-actions-provider"
  display_name                       = "GitHub Actions Provider"
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
}

resource "google_service_account_iam_member" "github_actions_sa_wi" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions_pool.name}/attribute.repository/${var.github_repo}"
}
