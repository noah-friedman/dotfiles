{ cask, lib, pkgs, stateVersion }: let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-${stateVersion}";
  });
in {
  imports = [nixvim.homeManagerModules.nixvim];

  packages = with pkgs; [
    nerdfonts
  ];
  overlays = [
    (final: prev: {
      nerdfonts = prev.nerdfonts.override {
        fonts = ["JetBrainsMono"];
      };
    })
  ];

  program = {
    enable = true;

    colorschemes.dracula-nvim = {
      enable = true;

      settings = {
        colors.menu = "none";
	transparent_bg = false;
	italic_comment = true;
	show_end_of_buffer = true;
      };
    };

    plugins = {
      cmp.enable = true;
      fidget.enable = true;
      lsp = {
        enable = true;

	inlayHints = true;

	servers = {
	  nil_ls.enable = true;
	};
      };
    };

    opts = {
      number = true;
    };
    withNodeJs = true;
  };

  neovide.program = {
    enable = true;

    package = if pkgs.stdenv.isDarwin
              then cask.neovide
	      else pkgs.neovide;

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
