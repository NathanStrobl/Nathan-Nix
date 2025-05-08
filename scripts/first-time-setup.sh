#!/bin/bash
echo -e "Installing Nix home-manager...\n"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

echo -e "Installing NixGL...\n"
nix-channel --add https://github.com/nix-community/nixGL/archive/main.tar.gz nixgl
nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault

echo -e "Running home-manager deployment for the first time...\n"
cd $HOME/Nathan-Nix/scripts
./redeploy.sh

echo -e "Creating Downloads directory in home folder...\n"
mkdir ~/Downloads

echo -e "Installing SpaceMono font...\n"
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/SpaceMono/Regular/SpaceMonoNerdFontMono-Regular.ttf
    fc-cache -f -v

echo -e "Setting Git global variables...\n"
git config --global user.email "nas4635@rit.edu"
git config --global user.name "Nathan Strobl"

cd $HOME
echo -e "\n\nSystem setup complete!\nPlease log out and log back in for changes to take effect.\n\n"
