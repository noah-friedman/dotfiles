{ lib, pkgs, ... }: {
  imports = let
    nixvim = import (builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      ref = "nixos-${import ../../version.nix}";
    });
  in [nixvim.homeManagerModules.nixvim];
  
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    colorschemes.dracula-nvim = {
      enable = true;
      settings = {
        colors.menu = "none";
        transparent_bg = false;
        italic_comment = true;
        show_end_of_buffer = true;
      };
    };

    extraFiles = (import ../../mkDir.nix {
      inherit lib;
      path = ./files;
    }).config;
  };
}
