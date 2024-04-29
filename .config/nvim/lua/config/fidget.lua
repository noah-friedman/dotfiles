local M = {}

function M.setup()
  require "fidget".setup {
    progress = {
      ignore_done_already = true,
      ignore_empty_message = true,
    },
    notification = {
      window = {
        winblend = 0,
      },
    },
  }
end

return M
