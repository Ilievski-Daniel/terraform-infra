module "voting_app_node_pool" {
  source = "../../modules/gcp/k8s-node-pool"

  name         = "pool-01"
  project      = var.gcp_project_id
  cluster_zone = var.zone
  cluster_name = module.cluster.name

  # Clusters were created with default service accounts
  service_account = "default"

  auto_upgrade          = true
  autoscaling_enabled   = true
  autoscaling_max_nodes = var.max_nodes
  disk_size_gb          = 100
  machine_type          = var.machine_type
  
  labels = {
    project = local.project_name
    env     = var.environment
  }
}
