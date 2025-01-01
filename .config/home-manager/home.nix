{ config, lib, pkgs, ... }:

let
  currentSystem = if lib.strings.hasSuffix "darwin" builtins.currentSystem
                  then "darwin"
                  else "linux";

  cmake = import ./cmake.nix { inherit pkgs; };
  darwin = import ./darwin.nix { inherit pkgs; };
  eza = import ./eza.nix { inherit currentSystem lib; };
  gpg = import ./gpg;
  neovim = import ./neovim.nix { inherit currentSystem pkgs; };
  neovide = neovim.neovide;
  rust = import ./rust.nix { inherit config pkgs; };
  trashy = import ./trashy.nix { inherit currentSystem pkgs; };
  zsh = import ./zsh { inherit config currentSystem lib pkgs; };
in {
  home = rec {
    username = "speelbarrow";
    homeDirectory = let 
      home_prefix = if currentSystem == "darwin" then "Users" else "home";
    in "/${home_prefix}/${username}";
    stateVersion = lib.strings.fileContents "${homeDirectory}/.nix";

    packages = let
      unstable = import <nixpkgs-unstable> {};
    in (with pkgs; [
      docker
      unstable.ghostty
    ])
      ++ cmake.packages
      ++ darwin.packages
      ++ neovim.packages
      ++ rust.packages
      ++ trashy.packages
      ++ zsh.packages;

    sessionVariables = {}
      // cmake.env
      // rust.env;

    shellAliases = {
      python = "python3";
    }
      // cmake.aliases
      // eza.aliases
      // trashy.aliases;
  };

  programs = {
    eza = eza.program;
    go.enable = true;
    gpg = gpg.program;
    home-manager.enable = true;
    neovim = neovim.program;
    neovide = neovide.program;
    zsh = zsh.program;
  };
}
