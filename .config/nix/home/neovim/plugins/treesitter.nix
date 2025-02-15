{ ... }: builtins.mapAttrs (n: v: {
  enable = true;
} // v) {
  treesitter = {
    enable = true;
    lazyLoad.enable = false;

    gccPackage = null;

    settings = {
      indent.enable = true;
      highlight.enable = true;
    };
  };
  treesitter-context = {
    lazyLoad.settings.event = "User FileOpened";
    settings = {
      mode = "topline";
      multiwindow = true;
      zindex = 100;
    };
  };
  treesitter-refactor = {
    smartRename = {
      enable = true;
      keymaps.smartRename = "<F2>";
    };
  };
  treesitter-textobjects.lspInterop.enable = true;
  ts-autotag.lazyLoad.settings.event = "User FileOpened";
  ts-comments.lazyLoad.settings.event = "User FileOpened";
}
