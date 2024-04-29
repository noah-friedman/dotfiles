local M = {}

function M.setup()
  local colors = require "dracula".colors()

  vim.notify = require "notify"

  ---@diagnostic disable-next-line: missing-fields, undefined-field
  vim.notify.setup {
    fps = 60,
    background_colour = colors["bg"],
    stages = "slide",

    -- Must set explicitly or bold highlight won't work
    render = "default",
  }

  for level, color in pairs {
    ERROR = "red",
    WARN = "yellow",
    INFO = "green",
    DEBUG = "cyan",
    TRACE = "white",
  }
  do
    vim.api.nvim_set_hl(0, "Notify" .. level .. "Border", { fg = colors[color] })
    vim.api.nvim_set_hl(0, "Notify" .. level .. "Icon", { fg = colors["bright_" .. color] })
    vim.api.nvim_set_hl(0, "Notify" .. level .. "Title", { fg = colors["bright_" .. color], bold = true })
  end
end

return M
