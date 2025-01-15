{ casks, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    docker
    casks.ghostty
    git
    neovim
    casks.neovide
    ripgrep
    wireguard-tools
    yadm
    zsh
  ];
}
