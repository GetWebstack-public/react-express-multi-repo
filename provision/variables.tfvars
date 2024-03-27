# Generic
cluster_name = "getwebstack-cluster"

# Minikube
minikube_driver = "docker"

# Google Cloud Platform
project_id = "getwebstack-test-1"
seed_project_id = "gewestack-test-seed-project"
region     = "europe-west1"
zone       = "europe-west1-b"
org_id     = null
billing_account = "016452-6E0FF0-80E88A"
gke_num_nodes   = 1

# KubeADM
k8s_controller_instances = {
    milo = {
        host = "192.168.1.14",
        ssh_user = "pi",
        ssh_private_key = "~/.ssh/pi5-milo"
    }
}
k8s_worker_instances = {
    coco = {
        host = "192.168.1.15",
        ssh_user = "pi",
        ssh_private_key = "~/.ssh/coco"
    }
}
