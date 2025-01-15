{ pkgs, ... }: let
  fonts = import ../fonts.nix { inherit pkgs; };
  inherit (fonts.fonts) packages;
in {
  home = { inherit packages; };
} // builtins.removeAttrs fonts ["fonts"]
