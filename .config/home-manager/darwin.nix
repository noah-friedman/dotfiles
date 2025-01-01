{ pkgs }: {
  packages = let
      nixcasks = import (fetchTarball "https://github.com/jacekszymanski/nixcasks/archive/master.tar.gz") {
        inherit pkgs;
      };
  in with pkgs nixcasks; [
  ];
}
