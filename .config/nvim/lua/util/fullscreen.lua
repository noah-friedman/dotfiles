return vim.schedule_wrap(function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  vim.api.nvim_exec_autocmds("User", { pattern = "NeovideFullscreen", data = vim.g.neovide_fullscreen })
end)
