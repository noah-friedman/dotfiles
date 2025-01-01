{ config, currentSystem, lib, pkgs, ... }:
{
  program = let
    dot = "${config.xdg.dataHome}/zsh";
  in {
    enable = true;

    autosuggestion.enable = true;

    dotDir = lib.strings.removePrefix "${config.home.homeDirectory}/" dot;

    defaultKeymap = "emacs";

    envExtra = let 
      paths = lib.strings.concatMapStringsSep " " (x: ''"${x}"'') [  
        "$HOME/.local/bin"
        "${config.home.profileDirectory}/bin"
      ];
    in "path+=(${paths})";

    initExtraBeforeCompInit = lib.strings.concatLines (
      lib.lists.flatten [
        (import ./local.nix {
          inherit dot lib config pkgs; 
          path = "before";
        })
        (import ./recursive.nix {
          inherit dot lib;
          path = ./before/.;
        })
      ]
    );

    initExtra = lib.strings.concatLines (
      lib.lists.flatten [
        [
          "if [ -d '${config.xdg.configHome}/zsh' ]; then"
          "\tfor file in ${config.xdg.configHome}/zsh/**/*; do"
          "\t\techo \"$file\""
          "\t\t. \"$file\""
          "\tdone"
          "fi"
          "if [ -d '${config.xdg.configHome}/local/zsh' ]; then"
          "\tfor file in ${config.xdg.configHome}/local/zsh/**/*; do"
          "\t\techo \"$file\""
          "\t\t. \"$file\""
          "\tdone"
          "fi"
        ]
        (import ./recursive.nix {
          inherit dot lib;
          path = ./after/.;
        })
        (import ./local.nix {
          inherit dot lib config pkgs; 
          path = "after";
        })
      ]
    );

    localVariables = let
      linux = if currentSystem == "linux"
              then {
                DEBIAN_PREVENT_KEYBOARD_CHANGES = "yes";
              }
              else {};
    in {
      DRACULA_DISPLAY_CONTEXT = 1;
      DRACULA_DISPLAY_FULL_CWD = 1;
      DRACULA_ARROW_ICON = "-> "; 
      ZSH_THEME = "dracula";
    } 
      // linux;

    plugins = [
      {
        name = "zsh-autoswitch-virtualenv";
        file = "autoswitch_virtualenv.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-autoswitch-virtualenv";
          rev = "3.7.1";
          sha256 = "hwg9wDMU2XqJ5FQEwMVVaz0n+xZ8NI82tH9VhLfFRC4=";
        };
      }
      {
        name = "dracula";
        file = "dracula.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "speelbarrow";
          repo = "dracula-zsh";
          rev = "master";
          sha256 = "wPoUlsihhgg+emH/X78juE6GxJcEFggQAPG8kvj44ks=";
        };
      }
    ];

    syntaxHighlighting.enable = true;
  };

  packages = with pkgs; [
    virtualenv
    ripgrep
  ];
}
