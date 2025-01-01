{ config, pkgs, ... }: {
  packages = with pkgs; [
    rustup
    espup
  ];

  env = {
    RUST_BACKTRACE = 1;
    ESPUP_EXPORT_FILE = "${config.home.homeDirectory}/.config/local/zsh/esp.zsh";
  };
}
