#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash google-cloud-sdk opentofu minikube docker
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/6ed8f0348cf12a3d4ed2c7c535a21e3cdbd850f5.tar.gz

set -euo pipefail

# Can be either production / development / prod / dev
ENVIRONMENT=$1

# If ENVIRONMENT is prod or dev, set it to production or development
if [ "$ENVIRONMENT" == "prod" ]; then
    ENVIRONMENT="production"
elif [ "$ENVIRONMENT" == "dev" ]; then
    ENVIRONMENT="development"
fi

# If first argument is not set or it's not production or development, exit
if [ -z "$ENVIRONMENT" ] || [ "$ENVIRONMENT" != "production" ] && [ "$ENVIRONMENT" != "development" ]; then
    echo "Please provide an environment name. Valid values are production and development."
    exit 1
fi

cd $ENVIRONMENT

# Pre-provision apply
if [ "$ENVIRONMENT" == "production" ]; then
    {
        gcloud auth application-default login
    } || {
        cd ..
    }
    elif [ "$ENVIRONMENT" == "development" ]; then
    {
        docker context use default
    } || {
        cd ..
    }
fi

{
    tofu workspace select -or-create $ENVIRONMENT &&
    tofu init &&
    tofu apply
} || {
    cd ..
}

# Post-provision apply
if [ "$ENVIRONMENT" == "production" ]; then
    {
        gcloud container clusters get-credentials $(tofu output -raw kubernetes_cluster_name) --region $(tofu output -raw region) --project $(tofu output -raw project_id)
    } || {
        cd ..
    }
elif [ "$ENVIRONMENT" == "development" ]; then
    {
        minikube profile  $(tofu output -raw cluster_name)
    } || {
        cd ..
    }
fi

cd ..
