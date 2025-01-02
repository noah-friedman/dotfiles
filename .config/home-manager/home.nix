{ config, lib, pkgs, ... }:

let
  username = "speelbarrow";
  homeDirectory = let
    prefix = if (import <nixpkgs> {}).stdenv.isDarwin then "Users" else "home";
  in "/${prefix}/${username}";
  stateVersion = lib.strings.fileContents "${homeDirectory}/.nix";

  cask = if pkgs.stdenv.isDarwin
          then (import (fetchTarball "https://github.com/jacekszymanski/nixcasks/archive/master.tar.gz") {
              inherit pkgs;
            })
          else null;

  cmake = import ./cmake.nix { inherit pkgs; };
  eza = import ./eza.nix { inherit lib pkgs; };
  git = import ./git;
  gpg = git.gpg;
  neovim = import ./neovim.nix { inherit cask lib pkgs stateVersion; };
  neovide = neovim.neovide;
  rust = import ./rust.nix { inherit config pkgs; };
  trashy = import ./trashy.nix { inherit pkgs; };
  zsh = import ./zsh { inherit config lib pkgs; };
in {
  imports = []
    ++ neovim.imports;

  home = {
    inherit username homeDirectory stateVersion;

    packages = let
      ghostty = if pkgs.stdenv.isDarwin
                then [cask.ghostty]
                else [pkgs.ghostty];
    in (with pkgs; [
      docker
      vesktop
    ])
      ++ ghostty
      ++ cmake.packages
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

  nixpkgs.overlays = []
    ++ neovim.overlays;

  programs = {
    eza = eza.program;
    git = git.program;
    go.enable = true;
    gpg = gpg.program;
    home-manager.enable = true;
    nixvim = neovim.program;
    neovide = neovide.program;
    zsh = zsh.program;
  };
}
