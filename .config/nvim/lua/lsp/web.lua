require "util.configure".lsp {
  lsp = "html",
  pattern = { "*.html", "*.js", "*.ts" },
  derive_filetypes = false,
}

require "util.configure".lsp {
  lsp = "cssls",
  pattern = "*.css",
}

require "util.configure".lsp {
  lsp = function()
    require "typescript-tools".setup {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          importModuleSpecifierPreference = "non-relative",
        }
      }
    }
  end,
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
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
  pattern = { "*.html", "*.js", "*.ts", "*.jsx", "*.tsx", "*.mdx" },
  derive_filetypes = false,
  default_filetypes = false,
  config = {
    filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "mdx" },
    ---@param client lsp.Client
    on_attach = function(client, _)
      client.server_capabilities.hoverProvider = false
    end
  },
}
