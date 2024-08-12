output "name" {
  description = "The name of the Google Kubernetes Engine (GKE) cluster."
  value       = google_container_cluster.gcp_gke_cluster.name
}

output "project" {
  description = "The Google Cloud project ID where the GKE cluster is located."
  value       = google_container_cluster.gcp_gke_cluster.project
}

output "location" {
  description = "The geographic location or region where the GKE cluster is deployed."
  value       = google_container_cluster.gcp_gke_cluster.location
}

output "pods_address_range" {
  description = "The IP address range allocated for Pods within the GKE cluster."
  value       = google_container_cluster.gcp_gke_cluster.cluster_ipv4_cidr
}

output "service_account" {
  description = "The service account used for managing resources and operations."
  value       = local.service_account
}
