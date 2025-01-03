vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  callback = function(args)
    vim.api.nvim_exec_autocmds("User", {
      pattern = "FileOpened",
    })
  end,
})
