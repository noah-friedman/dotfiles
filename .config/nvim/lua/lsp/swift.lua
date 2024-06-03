require "util.configure".lsp {
  lsp = "sourcekit",
  pattern = "*.swift",
  config = {
    cmd = { "sourcekit-lsp", "--sync" },
  },
}
