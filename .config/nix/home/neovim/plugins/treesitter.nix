{ lib, pkgs, ... }: {
  treesitter = {
    enable = true;
    lazyLoad.settings.event = "User DeferredUIEnter";

    settings.highlight.enable = true;
  };
}
