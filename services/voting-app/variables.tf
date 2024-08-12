variable "gcp_project_id" {
  type        = string
  description = "The ID of the project in GCP."
}

variable "environment" {
  description = "Runtime environment (dev, stage, prod)."
}

variable "network_description" {
  description = "Network description."
  default     = null
}

# variable "network_id" {
#   type = number
#   description = "Second octet of the network CIDR range. You should choose an available subnet."
# }

variable "region" {
  type = string
  description = "Deployment region."
}

variable "zone" {
  type = string
  description = "Deployment zone."
}

variable "max_nodes" {
  type = number
  default = 6
}

variable "machine_type" {
  type = string
  default = "n1-standard-4"
}
