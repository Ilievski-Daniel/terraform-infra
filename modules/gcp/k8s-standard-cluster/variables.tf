variable "project" {
  type        = string
  description = "GCP Project ID."
}

variable "name" {
  type = string
  description = "Cluster name."
}

variable "location" {
  type = string
  description = "Cluster location."
}

variable "initial_node_count" {
  type = number
  default = 1
  description = "The number of nodes to create in this cluster's default node pool."
}

variable "resource_labels" {
  type = map(string)
  description = "Cluster labels."
  default = {}
}

variable "service_account" {
  type = string
  default = null
  description = "The service account to be used by the Node VMs."
}

variable "should_create_service_account" {
  type = bool
  default = false
  description = "Create a non default service account for GKE Cluster."
}

# TODO: Remove, maybe not needed
variable "tags" {
  type = list(string)
  description = "GKE Cluster tags."
  default = []
}

variable "default_service_account_id" {
  type = string
  default = null
  description = "Use this variable if you want to change just the id of automatically created service account. This might come in handy if generated service account name is already taken."
}

variable "master_version" {
  type = string
  description = "Kubernetes min master version."
  default = null
}

variable "vpc" {
  type = string
  description = "VPC name."
  default = null
}

variable "vpc_subnet" {
  type = string
  description = "Subnetwork name."
  default = null
}

variable "vpc_pod_cidr_range_name" {
  type        = string
  description = "VPC pod range name."
  default     = null
}

variable "vpc_service_cidr_range_name" {
  type = string
  description = "VPC service range name."
  default = null
}

variable "daily_maintenance_window" {
  default = null
  description = "Daily maintenance policy with start time. Start time must be in format HH:mm in GMT."
  type = object({
    start_time = string
  })
}

variable "recurring_window" {
  default = null
  description = "Time window for recurring maintenance operations."
  # Specify 'start_time' and 'end_time' in RFC3339 'Zulu' date format. The start time's date is the initial date that the
  # Window starts, and the end time is used for calculating duration. Specify recurrence in RFC5545 RRULE format,
  # To specify when this recurs. Note that GKE may accept other formats, but will return values in UTC, causing a permanent diff.
  type = object({
    start_time = string
    end_time = string
    recurrence = string
  })
}

variable "release_channel" {
  default = "UNSPECIFIED"
  description = "Configuration options for the Release channel feature. One of UNSPECIFIED, STABLE, RAPID, REGULAR."
}

variable "maintenance_exclusions" {
  default = null
  description = "Exceptions to maintenance window, recurrence not supported."
  type = set(object({
    exclusion_name = string
    start_time = string
    end_time = string
  }))
}

variable "logging_service" {
  type = string
  description = "K8s logging service."
  default = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  type = string
  description = "K8s monitoring service."
  default = "monitoring.googleapis.com/kubernetes"
}

variable "enable_shielded_nodes" {
  type = bool
  default = false
  description = "Enable Shielded Nodes features on all nodes in this cluster"
}

variable "cluster_autoscaling" {
  type = object({
    cpu_min = number
    cpu_max = number
    mem_min = number
    mem_max = number
  })
  default = null
  description = "Per-cluster configuration of Node Auto-Provisioning with Cluster Autoscaler to automatically adjust the size of the cluster and create/delete node pools based on the current needs of the cluster's workload."
}

variable "enabled_worker_identity" {
  default = false
  type = bool
  description = "Workload Identity allows Kubernetes service accounts to act as a user-managed Google IAM Service Account."
}

variable "enable_filestore_csi_driver" {
  default = false
  type = bool
  description = "The status of the Filestore CSI driver addon, which allows the usage of filestore instance as volumes. It is disabled by default"
}