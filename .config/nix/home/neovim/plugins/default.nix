{ lib, ... } @ args: import ../../../mkDir.nix {
  inherit args lib;
  path = ./.;
  extra = [{
    dressing = {
      enable = true;
      lazyLoad.settings.event = "User DeferredUIEnter";
    };
    lz-n.enable = true;
    web-devicons.enable = true;
  }];
}
