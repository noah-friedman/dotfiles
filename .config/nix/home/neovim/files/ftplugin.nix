{ ... }: {
  "ftplugin/nix.lua".text = ''
    vim.o.shiftwidth = 2
    vim.o.softtabstop = 2
    vim.o.tabstop = 2
  '';
}
