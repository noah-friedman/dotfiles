local M = {}

function M.setup()
  require "lsp-format".setup {
    c = {
      exclude = { "clangd" },
    },
    cpp = {
      exclude = { "clangd" },
    }
  }
end

return M
