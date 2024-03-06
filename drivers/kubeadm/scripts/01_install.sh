#!/bin/bash

set -euo pipefail

# For Raspberry Pi
# sudo vi /boot/firmware/cmdline.txt
# Add cgroup_enable=memory cgroup_memory=1
# sudo reboot

# 01 containerd installaation and configuration
sudo apt update
sudo apt install containerd -y
mkdir -p /etc/containerd
containerd config default  /etc/containerd/config.toml

sudo systemctl restart containerd

# 02 kubernetes component installation
export KUBERNETES_VERSION=1.29

sudo apt-get update &&  sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v${KUBERNETES_VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg --yes
eval "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${KUBERNETES_VERSION}/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list"

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


# 03 network configuration
sudo tee /etc/modules-load.d/k8s.conf > /dev/null <<EOF
overlay
br_netfilter
EOF

#disable swaping
sudo sed 's/#   /swap.*/#swap.img/' /etc/fstab
sudo swapoff -a

sudo systemctl restart kubelet.service

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/k8s.conf > /dev/null <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
