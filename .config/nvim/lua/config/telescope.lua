local M = {}

function M.setup()
  local telescope = require "telescope"
  telescope.setup {
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
