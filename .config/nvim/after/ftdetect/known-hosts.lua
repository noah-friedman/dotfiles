vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "known_hosts",
  callback = function()
    vim.wo.wrap = false
  end
})
