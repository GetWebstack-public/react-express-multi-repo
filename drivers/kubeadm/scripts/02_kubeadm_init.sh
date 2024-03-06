#!/bin/bash

set -euo pipefail

sudo kubeadm init \
  --pod-network-cidr=192.168.0.0/16 \
  --node-name $HOSTNAME

# 02 copy kubeconfig
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# install Calico
kubectl create -f  https://raw.githubusercontent.com/projectcalico/calico/v3.27.2/manifests/calico.yaml
