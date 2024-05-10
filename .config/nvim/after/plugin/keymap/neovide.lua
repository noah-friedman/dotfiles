for _, config in ipairs {
  {
    lhs = "<M-f>",
    rhs = require "util.fullscreen",
  },
  {
    lhs = "<D-c>",
    rhs = '"*y',
    mode = "v",
  },
  {
    lhs = "<D-x>",
    rhs = '"*x',
    mode = "v",
  },
  {
    lhs = "<D-v>",
    rhs = '"*p',
    mode = { "n", "v" },
  },
  {
    lhs = "<D-v>",
    rhs = '<Esc>"*pa',
    mode = "i",
  },
  {
    lhs = "<D-v>",
    rhs = '<C-\\><C-n>"*pa',
    mode = "t",
  },
  {
    lhs = "<D-V>",
    rhs = '"*P',
    mode = { "n", "v" },
  },
  {
    lhs = "<D-V>",
    rhs = '<Esc>"*Pa',
    mode = "i",
  },
  {
    lhs = "<D-V>",
    rhs = '<C-\\><C-n>"*Pa',
    mode = "t",
  },
} do
  local lhs = config.lhs
  local rhs = (type(config.rhs) == "string" and
    vim.api.nvim_replace_termcodes(config.rhs --[[ @as string ]], true, false, true) or
    config.rhs)
  vim.keymap.set(config.mode or { "n", "i", "v" }, lhs, type(rhs) ~= "string" and rhs or function()
                   vim.api.nvim_feedkeys(rhs, "n", false)
                 end, { noremap = true })
end
