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
      file_browser = {
        hijack_netrw = true,
      },
    },
  }
end

return M
