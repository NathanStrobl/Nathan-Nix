#!/bin/bash

if [ ! -d "$HOME/.local/share/lunarvim" ]; then
    echo "Installing LunarVim..."
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.sh) --no-install-dependencies
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/SpaceMono/Regular/SpaceMonoNerdFontMono-Regular.ttf
    fc-cache -f -v
fi

exit