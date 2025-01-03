require "util.configure".lsp {
  lsp = "bashls",
  pattern = { "*.sh", "*.zsh" },
  config = {
    filetypes = { "bash" },
  },
}
