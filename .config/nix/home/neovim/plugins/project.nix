{ ... }: {
  project-nvim = {
    enable = true;
    enableTelescope = true;
    lazyLoad.settings.event = ["User DeferredUIEnter"];
    settings = {
      ignore_lsp = [
        "copilot"
        "lua_ls"
        "taplo"
        "rust-analyzer"
      ];
      patterns = [
        ".git"
        "Cargo.toml"
        "pyproject.toml"
        "package.json"
        ".project"
        ">.config"
      ];
      scope_chdir = "tab";
      silent_chdir = false;
    };
  };
}
