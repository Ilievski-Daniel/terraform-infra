output "workload_identity_provider" {
  value = google_iam_workload_identity_pool_provider.github_actions_provider.name
}

output "service_account_email" {
  value = google_service_account.github_actions.email
}
