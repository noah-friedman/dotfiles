{ isDarwin, ... }: {
  nix.nixPath = let
    prefix = if isDarwin then "darwin" else "nixos";
  in ["${prefix}-config=$HOME/.config/nix/configuration.nix"];
}
