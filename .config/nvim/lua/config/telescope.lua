local M = {}

function M.setup()
  local telescope = require "telescope"
  telescope.setup {
    pickers = {
      persisted = {
        sorting_strategy = "descending",
      },
    },
    extensions = {
      ["ui-select"] = {
        require "telescope.themes".get_cursor {}
      },
    },
  }
end

return M
