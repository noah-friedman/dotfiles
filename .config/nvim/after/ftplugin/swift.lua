local bufnr = vim.api.nvim_get_current_buf()

vim.schedule_wrap(vim.lsp.inlay_hint.enable)(false, { bufnr = bufnr })

vim.bo[bufnr].tabstop = 2
vim.bo[bufnr].softtabstop = 2
vim.bo[bufnr].shiftwidth = 2

---@type spLauncher.ActionMap
vim.b[bufnr].spLauncherActionMap = {
  base = "swift",
  run = "run %",
  debug = "run --debugger %",
  build = "build %",
}

require "spLauncher.util".workspace("sourcekit", {
                                      run = true,
                                      debug = "run --debugger",
                                      build = true,
                                      test = true,
                                      clean = true,
                                    }, bufnr)
