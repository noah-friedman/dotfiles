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
  config = {
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
    end,
    root_dir = require "lspconfig.util".root_pattern("tailwind.config.js", "tailwind.config.ts", "tailwind.config.json"),
  },
}
