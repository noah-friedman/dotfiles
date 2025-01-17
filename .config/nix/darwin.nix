{ lib, isDarwin, pkgs, ... }: let
  casks = import ./casks.nix pkgs;
in lib.mkIf isDarwin {
  environment.systemPackages = [
    casks.docker
  ];
  security.pam.enableSudoTouchIdAuth = true;
  nixpkgs.overlays = [
    (final: prev: with casks; {
      inherit ghostty neovide;
    })
  ];
}
