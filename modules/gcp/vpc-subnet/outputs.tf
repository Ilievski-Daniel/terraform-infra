output "name" {
  value       = google_compute_subnetwork.gcp_vpc_subnet.name
  description = "The name of the Google Compute Engine subnetwork."
}

output "ip_cidr_range" {
  value       = google_compute_subnetwork.gcp_vpc_subnet.ip_cidr_range
  description = "The IP CIDR range of the Google Compute Engine subnetwork."
}

output "self_link" {
  value       = google_compute_subnetwork.gcp_vpc_subnet.self_link
  description = "The self-link of the Google Compute Engine subnetwork."
}