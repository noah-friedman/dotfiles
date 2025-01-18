{ lib, ... }: {
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

    opts = {
      colorcolumn = "+1";
      number = true;
      signcolumn = "number";
      textwidth = 100;
    };

    extraFiles = (import ../../mkDir.nix {
      inherit lib;
      path = ./files;
    }).config;

    plugins = (import ../../mkDir.nix {
      inherit lib;
      path = ./plugins;
    }).config;
  };

  programs.neovide = {
    enable = true;
    settings = {
      frame = "transparent";
      font = let
        family = "JetBrainsMono Nerd Font";
      in {
        size = 14;
        normal = [{
          inherit family;
          style = "Normal";
        }];
        bold = [{
          inherit family;
          style = "ExtraBold";
        }];
        italic = [{
          inherit family;
          style = "Italic";
        }];
        bold_italic = [{
          inherit family;
          style = "ExtraBold-Italic";
        }];
      };
    };
  };
}
