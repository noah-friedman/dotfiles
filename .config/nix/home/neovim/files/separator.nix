{ ... }: {
  "after/plugin/separator.lua".text = ''
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = require "dracula".colors().white })
  '';
}
