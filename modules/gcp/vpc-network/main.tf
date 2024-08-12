resource "google_compute_network" "gcp_vpc_network" {
  name                            = var.name
  project                         = var.project
  description                     = var.description
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}
