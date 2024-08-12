locals {
  service_account = var.should_create_service_account ? google_service_account.service_account[0].email : var.service_account
  default_service_account_id = var.default_service_account_id == null ? replace(substr("svc-${var.name}", 0, 30), "/-$/", "") : var.default_service_account_id

  default_service_account_roles = [
    "roles/monitoring.viewer",
    "roles/monitoring.metricWriter",
    "roles/logging.logWriter"
  ]
}

resource "google_container_cluster" "gcp_gke_cluster" {
  name = var.name
  project = var.project
  location = var.location
  logging_service = var.logging_service
  monitoring_service = var.monitoring_service

  remove_default_node_pool = true
  enable_shielded_nodes = var.enable_shielded_nodes

  min_master_version = var.master_version
  network = var.vpc != null ? "projects/${var.project}/global/networks/${var.vpc}" : null
  subnetwork = var.vpc_subnet
  initial_node_count = var.initial_node_count
  release_channel {
    channel = var.release_channel
  }

  resource_labels = var.resource_labels

  dynamic "ip_allocation_policy" {
    for_each = var.vpc_pod_cidr_range_name == null && var.vpc_service_cidr_range_name == null ? [] : [1]
    content {
      cluster_secondary_range_name = var.vpc_pod_cidr_range_name
      services_secondary_range_name = var.vpc_service_cidr_range_name
    }
  }

  dynamic "maintenance_policy" {
    for_each = var.daily_maintenance_window == null && var.recurring_window == null ? [] : ["maintenance_policy"]
    content {
      dynamic "daily_maintenance_window" {
        for_each = var.daily_maintenance_window == null ? [] : list(var.daily_maintenance_window)
        content {
          start_time = var.daily_maintenance_window.start_time
        }
      }
      dynamic "recurring_window" {
        for_each = var.recurring_window == null ? [] : tolist([var.recurring_window])
        content {
          start_time = var.recurring_window.start_time
          end_time = var.recurring_window.end_time
          recurrence = var.recurring_window.recurrence
        }
      }
      dynamic "maintenance_exclusion" {
        for_each = var.maintenance_exclusions == null ? [] : var.maintenance_exclusions
        content {
          exclusion_name = maintenance_exclusion.value.exclusion_name
          start_time = maintenance_exclusion.value.start_time
          end_time = maintenance_exclusion.value.end_time
        }
      }
    }
  }

  dynamic "workload_identity_config" {
    for_each = var.enabled_worker_identity ? ["workload_identity"] : []
    content {
      workload_pool = "${var.project}.svc.id.goog"
    }
  }

  dynamic "cluster_autoscaling" {
    for_each = var.cluster_autoscaling == null ? [] : tolist(["cluster_autoscaling"])
    content {
      enabled = true
      resource_limits {
        resource_type = "cpu"
        minimum = var.cluster_autoscaling.cpu_min
        maximum = var.cluster_autoscaling.cpu_max
      }
      resource_limits {
        resource_type = "memory"
        minimum = var.cluster_autoscaling.mem_min
        maximum = var.cluster_autoscaling.mem_max
      }
      auto_provisioning_defaults {
        shielded_instance_config {
          enable_integrity_monitoring = true
          enable_secure_boot = false
        }
        oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
      }
    }
  }

  dynamic "addons_config" {
    for_each = var.enable_filestore_csi_driver ? ["addons_config"] : []
    content {
      gcp_filestore_csi_driver_config {
        enabled = var.enable_filestore_csi_driver
      }
    }
  }
}

resource "google_service_account" "service_account" {
  count = var.should_create_service_account ? 1 : 0
  project = var.project
  account_id = local.default_service_account_id
  display_name = local.default_service_account_id
}

resource "google_project_iam_member" "service_account_iam_role_binding" {
  count = var.should_create_service_account ? length(local.default_service_account_roles) : 0

  project = var.project
  role = local.default_service_account_roles[count.index]
  member = "serviceAccount:${google_service_account.service_account[0].email}"
}
