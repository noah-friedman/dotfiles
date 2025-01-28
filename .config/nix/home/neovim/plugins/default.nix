{ lib, pkgs, ... } @ args: import ../../../mkDir.nix {
  inherit args lib;
  path = ./.;
  extra = [{
    dressing = {
      enable = true;
      lazyLoad.settings.lazy = true;
    };
    lz-n.enable = true;
    web-devicons.enable = true;
  }];
}
