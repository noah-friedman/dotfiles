require "util.configure".lsp {
  lsp = "mdx_analyzer",
  pattern = "*.mdx",
  config = {
    init_options = {
      typescript = {
        enabled = true,
      }
    },
  },
}
