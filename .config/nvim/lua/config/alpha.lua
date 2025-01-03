local button = require "util.alpha".button

local M = {}

function M.setup()
  local config = require "alpha.themes.dashboard".config
  local localConfig = require "util.alpha".get()
  local base = localConfig and 12 or 10

  for i = 4, base, 2 do
    config.layout[i] = vim.deepcopy(config.layout[4])
  end
  config.layout[base + 2] = vim.deepcopy(config.layout[5])
  for i = 5, base + 1, 2 do
    config.layout[i] = { type = "padding", val = 1 }
  end

  config.layout[4].val = {
    button("󱪞  New File", "e", vim.cmd.enew),
    button("󱋢  Recent Files", "o", function() vim.cmd.Telescope "oldfiles" end),
  }
  config.layout[6].val = {
    button("󰩈  Exit", "q", vim.cmd.q),
  }
  config.layout[8].val = {
    button("󰪻  Recent Projects", "p", function() vim.cmd.Telescope "projects" end),
    button("󱏒  File Browser", "b", require "util.file_browser" (false)),
    button("󰱽  Find Files", "f", function() vim.cmd.Telescope "find_files" end),
    button("󱎸  Grep Search", "r", function() vim.cmd.Telescope "live_grep" end),
  }
  config.layout[10].val = {
    button("  Help Tags", "h", function() vim.cmd.Telescope "help_tags" end),
    button("󰞷  Terminal", "t", vim.cmd.terminal),
    button("󰦗  Update Plugins", "u", function()
      vim.cmd.TSUpdate()
      vim.cmd.Lazy "update"
    end),
  }
  if localConfig then
    config.layout[base].val = localConfig
  end
  require "alpha".setup(config)

  vim.api.nvim_create_autocmd("TabNewEntered", {
    callback = function(args)
      if vim.api.nvim_buf_get_name(args.buf) == "" and vim.g.SessionLoad ~= 1 then
        vim.schedule_wrap(vim.cmd.bd)(args.buf)
        vim.cmd.Alpha()
      end
    end,
  })
end

return M
