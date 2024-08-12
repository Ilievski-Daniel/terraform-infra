variable "project" {
  type        = string
  description = "GCP Project ID."
}

variable "name" {
  type        = string
  description = "Subnet name."
}

variable "region" {
  type        = string
  description = "Specify if this is a regional network."
}

variable "network" {
  type        = string
  description = "The network this subnet belongs to."
}

variable "cidr_range" {
  type        = string
  description = "The range of IP addresses belonging to this subnetwork secondary range."
}

variable "private_ip_google_access" {
  type        = bool
  default     = true
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
}

variable "secondary_ip_ranges" {
  type        = list(object({ range_name = string, ip_cidr_range = string }))
  default     = []
  description = "A tupled array of configurations for secondary IP ranges for VM instances contained in this subnetwork. First element is IP range name second element is the cidr."
}

variable "purpose" {
  type        = string
  default     = null
  description = "The purpose of the network. Possible options are [PRIVATE_RFC_1918|REGIONAL_MANAGED_PROXY|GLOBAL_MANAGED_PROXY|PRIVATE_SERVICE_CONNECT]."
  validation {
    condition     = var.purpose != null ? contains(["PRIVATE_RFC_1918", "REGIONAL_MANAGED_PROXY", "GLOBAL_MANAGED_PROXY", "PRIVATE_SERVICE_CONNECT"], var.purpose) : true
    error_message = "Invalid purpose defined"
  }
  nullable = true
}

variable "role" {
  type        = string
  default     = null
  description = "The role of subnetwork. Currently, this field is only used when purpose is REGIONAL_MANAGED_PROXY. The value can be set to ACTIVE or BACKUP."
  validation {
    condition     = var.role != null ? contains(["ACTIVE", "BACKUP"], var.role) : true
    error_message = "Invalid role defined"
  }
  nullable = true
}
