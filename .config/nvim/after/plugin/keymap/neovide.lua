for _, config in ipairs {
  {
    lhs = "<M-f>",
    rhs = function()
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
      vim.api.nvim_exec_autocmds("User", { pattern = "NeovideFullscreen", data = true })
    end,
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
    rhs = '<Esc>"*Pa',
    mode = "i",
  },
  {
    lhs = "<D-v>",
    rhs = '"*p',
    mode = { "n", "v" },
  },
} do
  local lhs = config.lhs
  local rhs = (type(config.rhs) == "string" and
    vim.api.nvim_replace_termcodes(config.rhs --[[ @as string ]], true, false, true) or
    config.rhs)
  vim.keymap.set(config.mode or { "n", "i", "v" }, lhs, rhs, { noremap = true })
end
