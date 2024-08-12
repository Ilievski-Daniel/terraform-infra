variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "region" {
  description = "The region for GCP resources."
  type        = string
  default     = "us-central1"
}

variable "github_repo" {
  description = "The GitHub repository that will use this Workload Identity Provider."
  type        = string
}

variable "workload_identity_pool_id" {
  type = string
  description = "The ID of the Workload Identity Pool"
}
