resource "minikube_cluster" "cluster" {
  driver = var.minikube_driver
  cluster_name = var.cluster_name
}
