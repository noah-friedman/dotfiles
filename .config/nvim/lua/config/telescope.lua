local M = {}

function M.setup()
  local telescope = require "telescope"
  telescope.setup {
    defaults = {
      initial_mode = "normal",
    },
    extensions = {
      ["ui-select"] = {
        require "telescope.themes".get_cursor {}
      },
    },
  }
end

return M
