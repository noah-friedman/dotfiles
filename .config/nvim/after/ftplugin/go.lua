local buf = vim.api.nvim_get_current_buf()

vim.wo.foldmethod = "syntax"
vim.api.nvim_create_autocmd("BufWinLeave", {
  buffer = buf,
  command = "mkview",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  buffer = buf,
  command = "silent! loadview",
})

---@type spLauncher.ActionMap
vim.b[buf].spLauncherActionMap = {
  base = "go",
  run = "run %",
  debug = {
    handler = function()
      local temp = vim.fn.tempname()
      return "build -o " .. temp .. " % && dlv exec " .. temp
    end,
    config = {
      notify = true,
      window = {
        focus = "insert",
        persist = false,
      },
    },
  },
  test = "test %",
  build = "build %",
}

require "spLauncher.util".workspace("gopls", {
                                      debug = {
                                        handler = function()
                                          local temp = vim.fn.tempname()
                                          return "build -o " .. temp .. " && dlv exec " .. temp
                                        end
                                      },
                                      test = true,
                                      build = true,
                                      clean = {
                                        handler = true,
                                        config = {
                                          notify = true,
                                          silent = true,
                                        }
                                      },
                                    }, buf)
