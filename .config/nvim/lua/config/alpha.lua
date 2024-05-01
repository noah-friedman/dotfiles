local M = {}

---@param label string
---@param shortcut string
---@param action function
---@param config? table
---@return table
local function button(label, shortcut, action, config)
  return vim.tbl_deep_extend("force", {
                               type = "button",
                               val = label,
                               on_press = action,
                               opts = {
                                 keymap = { "n", shortcut, action, { noremap = true } },
                                 shortcut = shortcut,
                                 align_shortcut = "right",
                                 hl_shortcut = "Keyword",
                                 position = "center",
                                 cursor = 3,
                                 width = 50,
                               },
                             }, config or {})
end

function M.setup()
  local config = require "alpha.themes.dashboard".config
  config.layout[7] = vim.deepcopy(config.layout[5])
  config.layout[5] = vim.deepcopy(config.layout[3])
  config.layout[6] = vim.deepcopy(config.layout[4])
  config.layout[4].val = {
    button("󱪞  New File", "e", vim.cmd.enew),
    button("󱋢  Recent Files", "o", function() vim.cmd.Telescope "oldfiles" end),
    button("󰪻  Recent Projects", "p", function() vim.cmd.Telescope "projects" end),
    button("󱏒  File Browser", "b", function() vim.cmd.Telescope "file_browser" end),
    button("󰱽  Find Files", "s", function() vim.cmd.Telescope "find_files" end),
    button("󰞷  Terminal", "t", vim.cmd.terminal),
    button("󱐥  Plugins", "l", vim.cmd.Lazy),
  }
  config.layout[6].val = {
    button("󰊓  Toggle fullscreen", "f", vim.schedule_wrap(function()
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
      vim.api.nvim_exec_autocmds("User", { pattern = "NeovideFullscreen", data = vim.g.neovide_fullscreen })
    end)),
    button("󰩈  Exit", "q", vim.cmd.q),
  }
  require "alpha".setup(config)

  vim.api.nvim_create_autocmd("TabNewEntered", {
    callback = function(args)
      vim.schedule_wrap(vim.cmd.bd)(args.buf)
      vim.cmd.Alpha()
    end,
  })
end

return M
