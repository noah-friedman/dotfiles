{ lib, isDarwin, pkgs, ... }: let
  casks = import ./casks.nix pkgs;
in lib.mkIf isDarwin {
  environment = with pkgs; {
    systemPackages = [
      casks.docker
      casks.onyx
      darwin.libiconv
      docker
      raycast

      # Gets rid of the 'install command line tools' pop-up
      xcbuild
    ];
    variables.RUSTFLAGS = "-L ${darwin.libiconv}/lib";
  };
  nixpkgs.overlays = [
    (final: prev: with casks; {
      inherit ghostty neovide;
    })
  ];
  security.pam.enableSudoTouchIdAuth = true;
}
