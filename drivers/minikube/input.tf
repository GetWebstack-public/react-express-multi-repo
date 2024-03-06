variable "cluster_name" {
    type        = string
    description = "Cluster name"
}

variable "minikube_driver" {
    type        = string
    description = "minikube driver"
    default = "docker"
}
