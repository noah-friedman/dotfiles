for _, config in ipairs {
  {
    lhs = "<M-f>",
    rhs = require "util.fullscreen",
  },
  {
    lhs = "<C-c>",
    rhs = '"*y',
    mode = "v",
  },
  {
    lhs = "<C-x>",
    rhs = '"*x',
    mode = "v",
  },
  {
    lhs = "<C-v>",
    rhs = '<Esc>"*pa',
    mode = "i",
  },
  {
    lhs = "<C-v>",
    rhs = '"*p',
    mode = { "n", "v" },
  },
  {
    lhs = "<C-V>",
    rhs = '<Esc>"*Pa',
    mode = "i",
  },
  {
    lhs = "<C-V>",
    rhs = '"*P',
    mode = { "n", "v" },
  },
} do
  local lhs = config.lhs
  local rhs = (type(config.rhs) == "string" and
    vim.api.nvim_replace_termcodes(config.rhs --[[ @as string ]], true, false, true) or
    config.rhs)
  vim.keymap.set(config.mode or { "n", "i", "v" }, lhs, rhs, { noremap = true })
end
