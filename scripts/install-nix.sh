#!/bin/bash
echo -e "Installing Nix...\n"
curl -L https://nixos.org/nix/install | sh -s -- --daemon
exit