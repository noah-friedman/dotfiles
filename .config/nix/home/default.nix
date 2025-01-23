{ config, lib, pkgs, ... }: import ../mkDir.nix {
  args = { inherit config lib pkgs; };
  extra = [{ programs.home-manager.enable = true; }];
  inherit lib;
  path = ./.;
}
