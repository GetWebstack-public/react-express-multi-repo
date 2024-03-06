#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash opentofu
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

# Import variables from variables.sh
source ./variables.sh

# If $ENVIRONMENT is development then the path is $DEV_ENV_PATH, else it's $PROD_ENV_PATH
ENV_PATH=$(eval echo \$$(echo $ENVIRONMENT | tr '[:lower:]' '[:upper:]')_ENV_PATH)
echo "* Running in: $ENV_PATH"

echo "* Running pre-provision.sh for $ENVIRONMENT environment"
# Pre-provision
# Check if pre_provision.sh exists in $ENV_PATH path, if it does, run it
[ -f ./${ENV_PATH}/pre_provision.sh ] &&./${ENV_PATH}/pre_provision.sh

echo "* Provisioning infrastructure for $ENVIRONMENT environment"
tofu workspace select -or-create $ENVIRONMENT &&
tofu -chdir=${ENV_PATH} init &&
tofu -chdir=${ENV_PATH} apply

echo "* Running post-provision.sh for $ENVIRONMENT environment"
# Post-provision
# Check if post_provision.sh exists in $ENV_PATH path, if it does, run it
[ -f ./${ENV_PATH}/post_provision.sh ] &&./${ENV_PATH}/post_provision.sh
