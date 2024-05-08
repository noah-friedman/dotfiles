vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "term://*",
  callback = vim.schedule_wrap(function()
    vim.wo.number = false
    vim.wo.signcolumn = "no"
  end)
})
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "term://*",
  callback = vim.schedule_wrap(function(args)
    vim.wo.number = true
    vim.wo.signcolumn = "yes"
  end)
})
