-- Global editor settings
local opts = {
  -- Auto-save on `make` (and other commands)
  autowrite = true,

  -- Add a column to show where the lines wrap
  colorcolumn = "+1",

  -- Sometimes 'Gitsigns' takes a second to load, so this prevents the text from shifting
  signcolumn = "yes",

  -- Expand tab characters into some number of spaces
  expandtab = true,

  -- 't' flag autowraps based on textwidth
  formatoptions = vim.o.formatoptions .. "t",

  -- Enable mouse reporting
  mouse = "a",

  -- Show line numbers
  number = true,

  -- `Tab` key indent amount
  shiftwidth = 4,
  tabstop = 4,

  -- Default window-splitting behaviour
  splitbelow = true,
  splitright = true,

  -- Allow 'gui' colours in terminal environment
  termguicolors = true,

  -- Document textwidth
  textwidth = 120,

  -- Send event on mouse move
  mousemoveevent = true,

  -- For `tabby.nvim`
  showtabline = 2,
}

for key, value in pairs(opts) do
  vim.o[key] = value
end

vim.api.nvim_set_hl(0, "WinSeparator", { fg = require "dracula".colors()["white"] })
