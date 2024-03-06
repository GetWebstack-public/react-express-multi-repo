#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash google-cloud-sdk opentofu
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/6ed8f0348cf12a3d4ed2c7c535a21e3cdbd850f5.tar.gz

gcloud container clusters get-credentials $(tofu output -raw kubernetes_cluster_name) --region $(tofu output -raw region) --project $(tofu output -raw project_id)
