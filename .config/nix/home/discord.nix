{ pkgs, ... }: {
  home.packages = with pkgs; [
    vesktop
  ];
  programs.nixvim.plugins.presence-nvim.enable = true;
}
