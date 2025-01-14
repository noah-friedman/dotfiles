{ lib, pkgs, ... }: import ./mkDir.nix {
  args = {
    inherit lib pkgs;
    isDarwin = lib.hasSuffix "darwin" builtins.currentSystem;
  };
  filter = ["configuration.nix" "home" "mkDir.nix" "version.nix"];
  inherit lib;
  path = ./.;
}
