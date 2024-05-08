vim.api.nvim_create_autocmd("User", {
  pattern = "FugitiveChanged",
  callback = function()
    require "gitsigns.actions".refresh()
  end,
})
