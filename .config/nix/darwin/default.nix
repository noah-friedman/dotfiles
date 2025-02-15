{ lib, isDarwin, pkgs, ... }: let
  casks = import ./casks.nix pkgs;
in lib.mkIf isDarwin {
  environment = with pkgs; {
    systemPackages = [
      casks.docker
      casks.onyx
      darwin.libiconv
      imagemagick # required for folderify
      raycast
      (rustPlatform.buildRustPackage rec {
        pname = "folderify";
        version = "v4.0.1";
        cargoHash = "sha256-vMESB9VTUQI66dWtWAeL0Zo3RH4V8Zv/zjSTnKKEW1Y=";
        src = fetchFromGitHub {
          owner = "lgarron";
          repo = pname;
          rev = version;
          hash = "sha256-syhnX1volDBPcvwuqDkDLavrI3znjwlT4SXFq//OLdY=";
        };
      })

      # Gets rid of the 'install command line tools' pop-up
      llvmPackages.llvm
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
