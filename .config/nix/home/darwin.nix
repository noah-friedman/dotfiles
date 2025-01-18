{ lib, pkgs, ... }: let
  casks = import ../casks.nix pkgs;
in lib.mkIf pkgs.stdenv.isDarwin {
  programs.ghostty.settings = {
    font-thicken = true;
    background-blur-radius = 50;
    window-colorspace = "display-p3";
    macos-titlebar-style = "transparent";
    macos-icon = "custom-style";
    macos-icon-frame = "plastic";
    macos-icon-ghost-color = "green";
    macos-icon-screen-color = "red";
  };
  programs.ghostty.package = casks.ghostty // {
    meta.mainProgram = "ghostty";
  };
  programs.neovide.package = casks.neovide;
}
