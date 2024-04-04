local M = {}

function M.setup()
  local colors = require "dracula".colors()

  vim.notify = require "notify"

  ---@diagnostic disable-next-line: missing-fields
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
    vim.cmd.hi("Notify" .. level .. "Border guifg=" .. colors[color])
    vim.cmd.hi("Notify" .. level .. "Icon guifg=" .. colors["bright_" .. color])
    vim.cmd.hi("Notify" .. level .. "Title guifg=" .. colors["bright_" .. color] .. " gui=bold")
  end

  require "lsp-notify".setup()
end

return M
