local M = {}

function M.setup()
  require "lsp-format".setup {
    c = {
      exclude = { "clangd" },
    },
    cpp = {
      exclude = { "clangd" },
    },
    toml = {
      exclude = { "taplo" },
    }
  }
end

return M
