{ lib, pkgs, ... }: let 
  mkDir = args: (import ../../mkDir.nix (args // { inherit lib; }));
in {
  imports = let
    nixvim = import (builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      #ref = "nixos-${import ../../version.nix}";
      ref = "main";
    });
  in [nixvim.homeManagerModules.nixvim];
  
  programs.nixvim = let

    plugins = mkDir {
      args = { inherit lib pkgs; };
      path = ./plugins;
      extra = [{
        web-devicons.enable = true;
        lz-n.enable = true;
      }];
    };
  in {
    enable = true;
    nixpkgs = { inherit pkgs; };
    defaultEditor = true;
    vimAlias = true;

    colorschemes.dracula-nvim = {
      enable = true;
      lazyLoad.enable = true;
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

    extraFiles = (mkDir {
      args = { inherit pkgs; };
      path = ./files;
    });

    extraPlugins = plugins.imports;

    keymaps = (mkDir {
      args = {
        inherit lib;
        modifier = if pkgs.stdenv.isDarwin then "D" else "C";
        mode = ["n" "i" "v" "t" "c"];
      };
      path = ./keymaps;
    });

    plugins = plugins.config;

    userCommands = (mkDir {
      path = ./user;
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
