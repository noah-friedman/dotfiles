{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    docker
    ghostty
    git
    neovim
    neovide
    ripgrep
    wireguard-tools
    yadm
    zsh
  ];
}
