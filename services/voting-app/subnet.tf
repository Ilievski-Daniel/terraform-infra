module "voting_app_vpc_subnet" {
  source = "../../modules/gcp/vpc-subnet"

  name    = "voting-app-${var.region}-${var.environment}"
  project = var.gcp_project_id
  region  = var.region

  cidr_range               = local.node_cidr_range
  network                  = module.voting_app_vpc_network.name
  private_ip_google_access = true

  secondary_ip_ranges = [
    {
      range_name: "pods",
      ip_cidr_range: local.pod_cidr_range
    },
    {
      range_name: "services",
      ip_cidr_range: local.service_cidr_range
    }
  ]
}
