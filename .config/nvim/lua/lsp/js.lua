require "util.configure".lsp {
  lsp = "tsserver",
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
  config = {
    init_options = {
      preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        importModuleSpecifierPreference = "non-relative",
      },
    },
  },
}

require "util.configure".lsp {
  lsp = "eslint",
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
  config = {
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  },
}
