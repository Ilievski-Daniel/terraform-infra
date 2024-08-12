variable "project" {
  type = string
  description = "GCP Project ID."
}
variable "name" {
  type = string
  description = "Node pool name."
}
variable "cluster_name" {
  type = string
  description = "The cluster to create the node pool for."
}
variable "cluster_zone" {
  type = string
  description = "The region that hosts the cluster."
}
variable "labels" {
  type = map(string)
  description = "Node labels."
  default = {}
}
variable "tags" {
  type = list(string)
  description = "Node network tag."
  default = []
}
variable "service_account" {
  type = string
  description = "The service account to be used by the Node VMs."
}
variable "node_count" {
  type = number
  description = "Number of nodes. Use if autoscaling is disabled."
  default = null
}
variable "autoscaling_enabled" {
  type = bool
  default = false
  description = "True if autoscaling is enabled."
}
variable "autoscaling_min_nodes" {
  type = number
  default = 1
  description = "Minimum number of nodes. Use if autoscaling is enabled."
}
variable "autoscaling_max_nodes" {
  type = number
  default = 1
  description = "Maximum number of nodes. Use if autoscaling is enabled."
}
variable "preemptible" {
  type = bool
  default = false
  description = "Use preemtible VMs."
}
variable "oauth_scopes" {
  type = list(string)
  description = "API scope access."
  default = [
    "https://www.googleapis.com/auth/cloud-platform"]
}
variable "auto_upgrade" {
  type = bool
  description = "Is the node auto upgraded."
  default = false
}
variable "auto_repair" {
  type = bool
  description = "Is the node auto repair enabled."
  default = true
}
variable "machine_type" {
  type = string
  default = null
  description = "The Google Compute Engine machine type to use for the nodes."
}
variable "image_type" {
  type = string
  default = "COS_CONTAINERD" 
  description = "Type of the disk attached to each node. Supported values: COS_CONTAINERD, UBUNTU_CONTAINERD, WINDOWS_LTSC_CONTAINERD, WINDOWS_SAC_CONTAINERD."
}
variable "disk_type" {
  type = string
  default = "pd-standard"
  description = "Type of the disk attached to each node."
}
variable "disk_size_gb" {
  type = number
  default = 100
  description = "Size of the disk in GB attached to each node."
}
