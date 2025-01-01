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
