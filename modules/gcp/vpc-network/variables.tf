variable "project" {
  description = "GCP Project ID."
}

variable "name" {
  description = "VPC name."
}

variable "description" {
  description = "VPC description."
  default     = null
}

variable "auto_create_subnetworks" {
  description = "Enable auto subnet mode."
  default     = false
}

variable "routing_mode" {
  description = "Regional or global."
  default     = null
}

variable "delete_default_routes_on_create" {
  description = "If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation."
  default     = null
}
