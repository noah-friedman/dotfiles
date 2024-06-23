local M = {}

function M.setup()
  require "nvim-treesitter.configs".setup {
    ensure_installed = {
      "c", "lua", "vim", "vimdoc", "query", "html", "css", "javascript", "typescript", "tsx", "xml", "markdown",
    },
    highlight = {
      enable = true,
    },
  }
end

return M
