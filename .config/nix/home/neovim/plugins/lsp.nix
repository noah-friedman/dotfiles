{ ... }: {
  lsp = {
    enable = true;
    inlayHints = true;

    servers = {
      nixd.enable = true;
    };
  };
}
