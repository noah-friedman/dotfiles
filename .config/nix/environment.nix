{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    wireguard-ui
    yadm
    zsh
  ];
}
