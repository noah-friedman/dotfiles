require "util.configure".lsp {
  lsp = "mdx_analyzer",
  pattern = "*.mdx",
  config = {
    settings = {
      typescript = {
        enabled = true,
      }
    },
  },
}
