require "util.configure_lsp" {
  lsp = "bashls",
  pattern = { "*.sh", "*.zsh" },
  config = {
    filetypes = { "bash" },
  },
}
