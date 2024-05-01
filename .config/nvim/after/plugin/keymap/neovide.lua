for lhs, rhs in pairs {
  ["<M-f>"] = {
    rhs = function()
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
      vim.api.nvim_exec_autocmds("User", { pattern = "NeovideFullscreen", data = true })
    end,
    mode = { "n", "i", "v" },
  },
  ["<D-c>"] = '<Esc>"*y',
  ["<D-v>"] = '<Esc>"*p',
  ["<D-x>"] = '<Esc>"*x',
} do
  local mode = { "v" }
  if type(rhs) == "string" then
    rhs = vim.api.nvim_replace_termcodes(rhs, true, false, true)
  elseif type(rhs) == "table" then
    mode = rhs.mode
    ---@diagnostic disable-next-line: cast-local-type
    rhs = rhs.rhs
  end
  vim.keymap.set(mode, lhs, rhs, { noremap = true })
end
