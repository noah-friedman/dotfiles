require "util.configure".lsp {
  lsp = "html",
  pattern = "*.html",
}

require "util.configure".lsp {
  lsp = "cssls",
  pattern = "*.css",
}

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

require "util.configure".lsp {
  lsp = "custom_elements_ls",
  pattern = { "*.html", "*.js", "*.ts", "*.jsx", "*.tsx" },
  derive_filetypes = false,
  default_filetypes = false,
  config = {
    filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    ---@param client lsp.Client
    on_attach = function(client, _)
      client.server_capabilities.hoverProvider = false
    end
  },
}
