{ lib, pkgs, ... }: let
in import ./mkDir.nix {
  args = {
    inherit lib pkgs;
    isDarwin = lib.hasSuffix "darwin" builtins.currentSystem;
  };
  extra = [{ nixpkgs.config.allowUnfree = true; }];
  filter = ["configuration.nix" "home" "mkDir.nix" "user.nix" "version.nix"];
  inherit lib;
  path = ./.;
}
