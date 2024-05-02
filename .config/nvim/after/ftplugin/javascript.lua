local buf = vim.api.nvim_get_current_buf()

vim.bo[buf].tabstop = 2
vim.bo[buf].shiftwidth = 2

---@type spLauncher.ActionMap
vim.b[buf].spLauncherActionMap = {
  base = "bun",
  run = "run %",
  test = "test %:p",
}

require "spLauncher.util".workspace("tsserver", {
                                      run = "run start",
                                      test = "test",
                                      build = "run build",
                                      clean = "run clean",
                                    }, buf)
