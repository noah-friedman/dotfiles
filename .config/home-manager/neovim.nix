{ currentSystem, pkgs, ... }: {
  program = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
  };
  neovide.program = {
    enable = true;
    package = if currentSystem == "darwin" 
              then (import (fetchTarball
                            "https://github.com/jacekszymanski/nixcasks/archive/master.tar.gz") { 
                inherit pkgs; 
              }).neovide
              else pkgs.neovide;
    settings = {
      frame = "transparent";
      font = let
        family = "Monocraft Nerd Font";
      in {
        size = 14;
        normal = [{
          inherit family;
          style = "Normal";
        }];
        bold = [{
          inherit family;
          style = "SemiBold";
        }];
        italic = [{
          inherit family;
          style = "Italic";
        }];
        bold_italic = [{
          inherit family;
          style = "SemiBold-Italic";
        }];
      };
    };
  };
  packages = with pkgs; [
    monocraft
  ];
}
