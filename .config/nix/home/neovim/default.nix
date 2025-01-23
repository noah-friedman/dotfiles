{ lib, pkgs, ... }: let 
mkDir = args: (import ../../mkDir.nix (args // { inherit lib; }));
in {
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
      expandtab = true;
      mouse = "a";
      number = true;
      shiftwidth = 4;
      signcolumn = "number";  
      softtabstop = 4;
      splitbelow = true;
      splitright = true;
      tabstop = 4;
      textwidth = 100;
    };

    autoCmd = (mkDir {
      path = ./autocmd;
    });

    userCommands = (mkDir {
      path = ./user;
    });

    extraFiles = (mkDir {
      args = { inherit pkgs; };
      path = ./files;
    });

    keymaps = (mkDir {
      args = {
        inherit lib;
        modifier = if pkgs.stdenv.isDarwin then "D" else "C";
        mode = ["n" "i" "v" "t" "c"];
      };
      path = ./keymaps;
    });

    plugins = (mkDir {
      path = ./plugins;
      extra = [{
        web-devicons.enable = true;
      }];
    });
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
