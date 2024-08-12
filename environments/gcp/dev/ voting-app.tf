module "voting-app" {
  source              = "../../../services/voting-app"
  gcp_project_id      = data.google_project.danieli_playground.project_id
  environment         = local.environment
  network_description = "Kubernetes network for voting-app-${local.environment}"
  region              = "europe-west1"
  zone                = "europe-west1-b"
}