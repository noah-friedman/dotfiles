{ config, lib, pkgs, ... }: import ../mkDir.nix {
  args = {
    inherit config lib pkgs;
    casks = import ../casks.nix pkgs;
  };
  inherit lib;
  path = ./.;
}
