local M = {}

function M.setup()
  require "dressing".setup {
    input = {
      relative = "win",
    },
    select = {
      enabled = false,
    },
  }
end

return M
