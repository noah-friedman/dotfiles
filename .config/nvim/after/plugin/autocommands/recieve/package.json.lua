vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "package.json",
  callback = function(args)
    ---@param fname string
    local function checkFile(fname)
      return vim.fn.filereadable(vim.fn.fnamemodify(args.file, ":p:h") .. "/" .. fname) ~= 0
    end
    local r = {
      base = (checkFile "bun.lockb" and "bun run" or (checkFile "package-lock.json" and "npm run" or nil)),
      run = "start",
      debug = true,
      test = true,
      build = true,
      clean = true,
    }
    if r.base then
      vim.b[args.buf].spLauncherActionMap = r
    end
  end
})
