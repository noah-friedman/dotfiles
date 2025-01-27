{ lib, pkgs, ... }: {
  treesitter = {
    enable = true;
    lazyLoad.settings.event = "User FileOpened";

    settings.highlight.enable = true;
  };
}
