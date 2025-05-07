#!/bin/bash
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

if [ ! -d "$HOME/.local/share/lunarvim" ]; then
    echo -e "Installing LunarVim...\n"
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.sh) --no-install-dependencies

    echo -e "Installing SpaceMono font...\n"
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/SpaceMono/Regular/SpaceMonoNerdFontMono-Regular.ttf
    fc-cache -f -v
fi

echo -e "\n\nSystem setup complete!\n\n"