module "state-bucket" {
  source      = "../../../modules/gcp/bucket"
  project     = data.google_project.danieli_playground.project_id
  bucket_name = "danieli-poc-${local.environment}-bucket"
}

terraform {
  backend "gcs" {
    bucket  = "danieli-poc-dev-bucket"
  }
}
