{ lib, pkgs, ... }: let
in import ./mkDir.nix {
  args = {
    inherit lib pkgs;
    casks = import ./casks.nix pkgs;
    isDarwin = lib.hasSuffix "darwin" builtins.currentSystem;
  };
  filter = ["casks.nix" "configuration.nix" "home" "mkDir.nix" "user.nix" "version.nix"];
  inherit lib;
  path = ./.;
}
