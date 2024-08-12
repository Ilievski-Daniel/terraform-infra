resource "google_compute_subnetwork" "gcp_vpc_subnet" {
  name    = var.name
  network = var.network
  region  = var.region
  project = var.project

  ip_cidr_range            = var.cidr_range
  private_ip_google_access = var.private_ip_google_access

  purpose = var.purpose
  role    = var.purpose == "`REGIONAL_MANAGED_PROXY" ? var.role : null

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}
