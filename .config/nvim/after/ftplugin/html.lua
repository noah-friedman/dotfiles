local bufnr = vim.api.nvim_get_current_buf()

vim.bo[bufnr].tabstop = 2
vim.bo[bufnr].softtabstop = 2
vim.bo[bufnr].shiftwidth = 2

vim.b[bufnr].spLauncherActionMap = {
  run = {
    handler = "open %",
    config = {
      notify = true,
      silent = true,
    },
  }
}

require "spLauncher.util".workspace("custom_elements_ls", {
                                      run = "bun run start"
                                    }, bufnr)

require "otter".activate { "css", "javascript" }
