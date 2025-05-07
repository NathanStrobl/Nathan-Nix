#!/bin/bash

echo -e "Installing Nix...\n"
curl -L https://nixos.org/nix/install | sh -s -- --daemon

echo -e "Installing Nix home-manager...\n"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

echo -e "Installing NixGL...\n"
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl
nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault

echo -e "Creating Downloads directory in home folder...\n"
mkdir ~/Downloads

echo -e "\n\nSystem setup complete!\n\n"