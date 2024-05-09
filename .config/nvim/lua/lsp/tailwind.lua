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
  config = function()
    return require "cmp_nvim_lsp".default_capabilities()
  end
}
