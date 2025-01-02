{ currentSystem, pkgs, ... }: {
  program = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
  };
  neovide.program = {
    enable = true;
    package = with pkgs; neovide;
    settings = {
      frame = "transparent";
      font = let
        family = "JetBrains Mono Nerd Font";
      in {
        size = 14;
        normal = [{
          inherit family;
          style = "Normal";
        }];
        bold = [{
          inherit family;
          style = "ExtraBold";
        }];
        italic = [{
          inherit family;
          style = "Italic";
        }];
        bold_italic = [{
          inherit family;
          style = "ExtraBold-Italic";
        }];
      };
    };
  };
  packages = with pkgs; [
    jetbrains-mono
  ];
}
