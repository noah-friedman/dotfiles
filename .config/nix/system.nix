{ isDarwin, ... }: let
  version = import ./version.nix;
in {
  system = {
    nixpkgsRevision = version;
    stateVersion = if isDarwin then 5 else version;
  };
}
