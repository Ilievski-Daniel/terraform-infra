module "voting_app_github_actions_oidc" {
  source = "../../modules/gcp/ga-oidc"
  
  project_id                = var.gcp_project_id
  workload_identity_pool_id = "github-actions-pool-d"
  github_repo               = "Ilievski-Daniel/terraform-infra"
}
