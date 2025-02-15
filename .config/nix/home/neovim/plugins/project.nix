{ ... }: {
  project-nvim = {
    enable = true;
    enableTelescope = true;
    lazyLoad.settings.event = ["User DeferredUIEnter"];
    settings = {
      ignore_lsp = [
        "copilot"
        "lua_ls"
        "rust_analyzer"
        "taplo"
      ];
      patterns = [
        ".git"
        "Cargo.toml"
        "pyproject.toml"
        "package.json"
        ">.config"
        ">Git"
        ">Scratch"
      ];
      scope_chdir = "tab";
      silent_chdir = false;
    };
  };
}
