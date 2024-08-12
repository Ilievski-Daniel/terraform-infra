module "cluster" {
  source = "../../modules/gcp/k8s-standard-cluster"

  name       = local.project_name
  project    = var.gcp_project_id
  location   = var.zone
  vpc        = module.voting_app_vpc_network.name
  vpc_subnet = module.voting_app_vpc_subnet.name

  release_channel        = local.stable_channel
  recurring_window       = local.workdays_maintenance_reoccurrence
  maintenance_exclusions = local.new_year_holiday_maintenance_exclusions

  resource_labels = {
    project = local.project_name
    env     = var.environment
  }

  service_account             = "default"
  vpc_pod_cidr_range_name     = "pods"
  vpc_service_cidr_range_name = "services"
}
