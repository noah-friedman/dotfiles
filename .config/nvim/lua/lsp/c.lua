require "util.configure".lsp {
  lsp = "clangd",
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  config = {
    capabilities = {
      offsetEncoding = "utf-8"
    }
  }
}
