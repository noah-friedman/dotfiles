require "util.configure_lsp" {
  lsp = "clangd",
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  config = {
    capabilities = {
      offsetEncoding = "utf-8"
    }
  }
}
