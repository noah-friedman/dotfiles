{ lib, isDarwin, pkgs, ... }: let
  casks = import ./casks.nix pkgs;
in lib.mkIf isDarwin {
  environment.systemPackages = with pkgs; [
    casks.docker
  ];
  nixpkgs.overlays = [
    (final: prev: with casks; {
      inherit ghostty neovide;
    })
  ];
  security.pam.enableSudoTouchIdAuth = true;
}
