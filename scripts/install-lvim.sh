#!/bin/bash

if [ ! -d "$HOME/.local/share/lunarvim" ]; then
    echo "Installing LunarVim..."
    bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.sh) --no-install-dependencies
fi