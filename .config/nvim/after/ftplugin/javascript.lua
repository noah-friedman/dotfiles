local buf = vim.api.nvim_get_current_buf()

vim.bo[buf].tabstop = 2
vim.bo[buf].shiftwidth = 2

---@type spLauncher.ActionMap
vim.b[buf].spLauncherActionMap = {
  base = "npm",
  run = "run %",
  test = "test %:p",
}

require "spLauncher.util".workspace("tsserver", {
                                      run = "start",
                                      test = true,
                                      build = "run build",
                                    }, buf)
