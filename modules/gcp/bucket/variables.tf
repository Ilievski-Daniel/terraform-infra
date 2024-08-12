variable "project" {
  type = string
  description = "GCP Project ID."
}

variable "bucket_name" {
  type = string
  description = "The name of the GCS bucket."
}

variable "enable_versioning" {
  type        = bool
  description = "If specified, bucket versioning will be enabled."
  default     = true
}
