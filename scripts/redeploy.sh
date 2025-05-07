#!/bin/bash
cd ~/Nathan-Nix
git pull
cp -r ~/Nathan-Nix/* ~/.config/home-manager/
home-manager switch -b backup
