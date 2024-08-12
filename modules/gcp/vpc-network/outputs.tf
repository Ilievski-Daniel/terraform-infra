output "name" {
  description = "The name of the Google Cloud VPC network."
  value       = google_compute_network.gcp_vpc_network.name
}

output "id" {
  description = "The unique identifier of the Google Cloud VPC network."
  value       = google_compute_network.gcp_vpc_network.id
}
