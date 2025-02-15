{ ... }: {
  rust_analyzer = {
    enable = true;
    installCargo = false;
    installRustc = false;
    rootDir = ''function(file)
      local root = vim.fs.root(file, "Cargo.toml")
      vim.notify(root, vim.log.levels.DEBUG)
      return root
    end'';
    settings.cargo.targetDir = true;
  };
}
