resource "terraform_data" "controller" {
    for_each = var.k8s_controller_instances

    connection {
        type = "ssh"
        user = each.value.ssh_user
        private_key = file(each.value.ssh_private_key)
        host = each.value.host
    }

    provisioner "remote-exec" {
        scripts = [
        # "./scripts/01_install.sh",
        # "./scripts/02_kubeadm_init.sh"
        ]
    }

    provisioner "local-exec" {
        command = <<EOF
        rm -rvf ./scripts/03_kubeadm_join.sh
        echo "sudo sh -c 'echo 1 > /proc/sys/net/ipv4/ip_forward'" > ./scripts/03_kubeadm_join.sh
        /usr/bin/ssh -i /home/vlad/.ssh/pi5-milo ${each.value.ssh_user}@${each.value.host} 'kubeadm token create --print-join-command' >> ./scripts/03_kubeadm_join.sh
        EOF
    }
}

resource "terraform_data" "worker" {
    for_each = var.k8s_worker_instances

    connection {
        type = "ssh"
        user = each.value.ssh_user
        private_key = file(each.value.ssh_private_key)
        host = each.value.host
    }

    provisioner "remote-exec" {
        scripts = [
            "./scripts/01_install.sh",
            "./scripts/03_kubeadm_join.sh"
        ]
    }

    depends_on = [ terraform_data.controller ]
}
