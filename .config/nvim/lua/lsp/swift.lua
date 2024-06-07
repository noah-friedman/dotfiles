require "util.configure".lsp {
  lsp = "sourcekit",
  pattern = "*.swift",
  config = {
    on_attach = function(client, bufnr)
      client.capabilities.textDocument.inlayHint = {}
    end
  },
}
