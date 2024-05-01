vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "package.json",
  callback = function(args)
    ---@type spLauncher.ActionMap
    vim.b[args.buf].spLauncherActionMap = {
      base = "bun",
      run = "run start",
      build = "run build",
      test = "test",
    }
  end
})
