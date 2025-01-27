{ ... }: {
  lsp = {
    enable = true;
    lazyLoad.settings.event = ["User FileOpened"];
    inlayHints = true;

    servers = {
      nixd.enable = true;
    };
  };
}
