{ lib, isDarwin, pkgs, ... }: let
  casks = import ./casks.nix pkgs;
in lib.mkIf isDarwin {
  environment = with pkgs; {
    systemPackages = [
      casks.docker
      casks.onyx
      darwin.libiconv
      raycast

      # Gets rid of the 'install command line tools' pop-up
      xcbuild
    ];
    variables = rec {
      LIBRARY_PATH = "${darwin.libiconv}/lib";
      RUSTFLAGS = "-L ${LIBRARY_PATH}";
    };
  };
  nixpkgs.overlays = [
    (final: prev: with casks; {
      inherit ghostty neovide;
    })
  ];
  security.pam.enableSudoTouchIdAuth = true;
}
