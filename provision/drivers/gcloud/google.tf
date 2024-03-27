provider "google" {
  project = var.seed_project_id
  region  = var.region
  zone    = var.zone
}
