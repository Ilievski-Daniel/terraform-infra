resource "google_container_node_pool" "gcp_gke_node_pool" {
  name = var.name

  project = var.project
  cluster = var.cluster_name
  location = var.cluster_zone
  node_count = var.autoscaling_enabled ? null : var.node_count

  node_config {
    machine_type = var.machine_type
    tags = var.tags
    labels = var.labels

    preemptible = var.preemptible
    image_type = var.image_type

    service_account = var.service_account

    disk_type = var.disk_type
    disk_size_gb = var.disk_size_gb

    oauth_scopes = var.oauth_scopes
  }

  autoscaling {
    min_node_count = var.autoscaling_enabled != null ? var.autoscaling_min_nodes : null
    max_node_count = var.autoscaling_enabled != null ? var.autoscaling_max_nodes : null
  }

  management {
    auto_upgrade = var.auto_upgrade
    auto_repair = var.auto_repair
  }

  timeouts {
    create = "30m"
    update = "20m"
  }
  lifecycle {
    ignore_changes = [
      initial_node_count,
      # Changes in metadata forces node pool replacement
      node_config[0].metadata,
      autoscaling[0].location_policy
    ]
  }
}
