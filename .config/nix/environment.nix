{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    wireguard-tools
    yadm
  ];
}
