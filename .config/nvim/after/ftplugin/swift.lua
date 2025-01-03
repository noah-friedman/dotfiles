local bufnr = vim.api.nvim_get_current_buf()

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

require "spLauncher.util".workspace("sourcekit", function(root_dir)
                                      if vim.fn.globpath(root_dir, "*.xcodeproj") ~= "" then
                                        return {
                                          base = "xcodebuild",
                                          run = nil,
                                          debug = nil,
                                          build = ""
                                        }
                                      else
                                        return {
                                          run = true,
                                          debug = "run --debugger",
                                          build = true,
                                          test = true,
                                          clean = true,
                                        }
                                      end
                                    end, bufnr)
