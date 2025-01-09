{ cask, pkgs }: {

  packages = with pkgs; [
    act
    arduino-cli

    arduino-language-server
    bash-language-server
    lua-language-server
    nixd
    yaml-language-server

    nerdfonts
  ];

  overlays = [
    (final: prev: {
      nerdfonts = prev.nerdfonts.override {
        fonts = ["JetBrainsMono"];
      };
    })
  ];

  program = {
    enable = true;
    withNodeJs = true;
  };

  neovide.program = {
    enable = true;

    package = if pkgs.stdenv.isDarwin
              then cask.neovide
	      else pkgs.neovide;

    settings = {
      frame = "transparent";
      font = let
        family = "JetBrainsMono Nerd Font";
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
}
