variable "k8s_controller_instances" {
  type = map(object({
    ssh_user = string
    ssh_private_key = string
    host = string
  }))
}

variable k8s_worker_instances {
  type = map(object({
    ssh_user = string
    ssh_private_key = string
    host = string
  }))
}
