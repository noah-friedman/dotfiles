vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = vim.schedule_wrap(function()
    vim.wo.number = false
    vim.wo.signcolumn = "no"
    vim.wo.fillchars = "eob: "
  end)
})
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaClosed",
  callback = vim.schedule_wrap(function(args)
    vim.wo.number = true
    vim.wo.signcolumn = "yes"
    vim.wo.fillchars = ""
  end)
})
