local M = {}

---@param label string
---@param shortcut string
---@param action function
---@param config? table
---@param keyopts? table
---@return table
local function button(label, shortcut, action, config, keyopts)
  return vim.tbl_deep_extend("force", {
                               type = "button",
                               val = label,
                               on_press = action,
                               opts = {
                                 keymap = { "n", shortcut, action, keyopts or { noremap = true } },
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
  for i = 4, 12, 2 do
    config.layout[i] = vim.deepcopy(config.layout[4])
  end
  config.layout[14] = vim.deepcopy(config.layout[5])
  for i = 5, 13, 2 do
    config.layout[i] = { type = "padding", val = 1 }
  end

  config.layout[4].val = {
    button("󰊓  Toggle fullscreen", "<M-f>", require "util.fullscreen"),
    button("󰩈  Exit", "q", vim.cmd.q),
  }
  config.layout[6].val = {
    button("󱪞  New File", "e", vim.cmd.enew),
    button("󱋢  Recent Files", "o", function() vim.cmd.Telescope "oldfiles" end),
  }
  config.layout[8].val = {
    button("󰪻  Recent Projects", "p", function() vim.cmd.Telescope "projects" end),
    button("󰮳  Recent Sessions", "s", function() vim.cmd.Telescope "persisted" end),
    button("󱏒  File Browser", "b", function() vim.cmd.Telescope "file_browser" end),
    button("󰱽  Find Files", "f", function() vim.cmd.Telescope "find_files" end),
    button("󱎸  Grep Search", "r", function() vim.cmd.Telescope "live_grep" end),
    button("󰊢  Git Actions", "g", function()
             vim.cmd "Telescope builtin default_text=git"
           end, nil, { noremap = true, nowait = true })

  }
  config.layout[10].val = {
    button("󰞷  Terminal", "t", vim.cmd.terminal),
    button("󰦗  `update`", "U", function()
      require "spLauncher".direct_spLaunch("update", {
        window = {
          persist = false,
        },
      })
    end)
  }
  config.layout[12].val = {
    button("󱐥  Plugins", "l", vim.cmd.Lazy),
    button("󰦗  Update Plugins", "u", function() vim.cmd.Lazy "update" end),
  }
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
