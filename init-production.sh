#!/bin/bash

SEED_PROJECT_ID="gewestack-test-seed-project"
BILLING_ACCOUNT_ID="016452-6E0FF0-80E88A"

gcloud projects create ${SEED_PROJECT_ID} --set-as-default
gcloud beta billing projects link ${SEED_PROJECT_ID} --billing-account ${BILLING_ACCOUNT_ID}

gcloud iam service-accounts create terraform --display-name "Terraform admin account"
gcloud iam service-accounts keys create ~/.config/gcloud/terraform.json --iam-account terraform@${SEED_PROJECT_ID}.iam.gserviceaccount.com
gcloud projects add-iam-policy-binding ${SEED_PROJECT_ID} --member serviceAccount:terraform@${SEED_PROJECT_ID}.iam.gserviceaccount.com --role roles/viewer
gcloud projects add-iam-policy-binding ${SEED_PROJECT_ID} --member serviceAccount:terraform@${SEED_PROJECT_ID}.iam.gserviceaccount.com --role roles/storage.admin
gcloud projects add-iam-policy-binding ${SEED_PROJECT_ID} --member serviceAccount:terraform@${SEED_PROJECT_ID}.iam.gserviceaccount.com --role roles/editor
