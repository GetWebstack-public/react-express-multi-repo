#!/bin/bash
set -e

ENVIRONMENT=$1

# If first argument is not set or it's not production or development, exit
if [ -z "$ENVIRONMENT" ] || [ "$ENVIRONMENT" != "production" ] && [ "$ENVIRONMENT" != "development" ]; then
    echo "Please provide an environment name. Valid values are production and development."
    exit 1
fi

cd $ENVIRONMENT

# Pre-terraform apply
# if [ "$ENVIRONMENT" == "production" ]; then
#     {
#         gcloud auth application-default login
#     } || {
#         cd ..
#     }
# fi

{
    terraform workspace select -or-create $ENVIRONMENT &&
    terraform init &&
    terraform apply
} || {
    cd ..
}

# Post-terraform apply
if [ "$ENVIRONMENT" == "production" ]; then
    {
        gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region) --project $(terraform output -raw project_id)
    } || {
        cd ..
    }
elif [ "$ENVIRONMENT" == "development" ]; then
    {
        minikube profile  $(terraform output -raw cluster_name)
    } || {
        cd ..
    }
fi

cd ..
