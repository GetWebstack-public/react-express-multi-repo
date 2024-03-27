#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash skaffold
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/6ed8f0348cf12a3d4ed2c7c535a21e3cdbd850f5.tar.gz

cd ../test-infra-front
skaffold init
