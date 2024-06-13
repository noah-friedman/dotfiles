local M = {}

function M.setup()
  require "otter".setup {
    handle_leading_whitespace = true,
  }
end

return M
