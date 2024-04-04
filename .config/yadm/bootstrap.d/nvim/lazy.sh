#!/bin/sh

. "$UTIL"

if cmd_exists nvim && fs_exists "$HOME/.local/share/nvim/lazy/lazy.nvim"; then
        mkdir -p $HOME/.local/share/nvim/lazy 2>/dev/null
        git clone https://github.com/folke/lazy.nvim.git $HOME/.local/share/nvim/lazy/lazy.nvim --branch=stable 
fi
