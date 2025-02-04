{ config, lib, pkgs, ... }: import ../mkDir.nix {
  args = { inherit config lib pkgs; };
  inherit lib;
  path = ./.;
}
