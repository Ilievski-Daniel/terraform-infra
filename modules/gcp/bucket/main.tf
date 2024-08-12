resource "google_storage_bucket" "bucket" {
  project       = var.project
  name          = var.bucket_name
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"

  versioning {
    enabled = var.enable_versioning
  }
}
