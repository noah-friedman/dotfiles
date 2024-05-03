local leader = "<M-g>"


for mapping, action in pairs {
  a = {
    "Gitsigns stage_hunk",
  },
  r = {
    "Gitsigns reset_hunk",
  },
  u = "Gitsigns undo_stage_hunk",
  d = {
    "Gitsigns preview_hunk",
  },
  c = "tab Git commit",
  p = "Git push",
  x = function()
    vim.cmd "tab Git commit"
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveChanged",
      once = true,
      command = "Git push"
    })
  end,
  A = "Gitsigns stage_buffer",
  R = "Gitsigns reset_buffer",
  C = "tab Git commit --amend",
  P = "Git push -f",
  X = function()
    vim.cmd "tab Git commit --amend"
    vim.api.nvim_create_autocmd("User", {
      pattern = "FugitiveChanged",
      once = true,
      command = "Git push -f"
    })
  end,
} do
  if type(action) == "table" then
    vim.keymap.set("v", leader .. mapping, (type(action[1]) == string) and ("<Cmd>'<,'>" .. action[1]
      .. "<CR>") or action[1])
    action = action[1]
  end
  vim.keymap.set({ "n", "i" }, leader .. mapping, type(action) == "string" and ("<Cmd>" .. action ..
    "<CR>") or action)
end
