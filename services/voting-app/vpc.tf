module "voting_app_vpc_network" {
  source = "../../modules/gcp/vpc-network"

  name        = "${local.project_name}-${var.environment}"
  description = var.network_description
  project     = var.gcp_project_id
}
