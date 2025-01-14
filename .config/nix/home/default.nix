{ lib, pkgs, ... }: import ../mkDir.nix {
  args = { inherit lib pkgs; };
  inherit lib;
  path = ./.;
}
