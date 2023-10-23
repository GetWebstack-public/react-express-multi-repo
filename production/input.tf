variable "seed_project_id" {
  type        = string
  description = "project id"
}

variable "project_id" {
  type        = string
  description = "project id"
}

variable "region" {
  type        = string
  description = "region"
}

variable "zone" {
  type        = string
}

variable "org_id" {
  type        = string
}

variable "billing_account" {
  type        = string
}


variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "cluster_name" {
  type = string
  description = "The GKE cluster name"
}

variable "gcp_service_list" {
  description ="The list of apis necessary for the project"
  type = list(string)
  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}
