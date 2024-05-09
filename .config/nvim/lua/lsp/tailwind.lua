require "util.configure".lsp {
  lsp = "tailwindcss",
  pattern = {
    "*.html",
    "*.css",
    "*.js",
    "*.ts",
    "*.jsx",
    "*.tsx",
  },
  capabilities = false,
  config = {
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
    end
  },
}
