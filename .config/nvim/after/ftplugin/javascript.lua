local buf = vim.api.nvim_get_current_buf()

vim.bo[buf].tabstop = 2
vim.bo[buf].shiftwidth = 2

---@type spLauncher.ActionMap
vim.b[buf].spLauncherActionMap = {
  base = "bun",
  run = "run %",
  test = "test %:p",
}

require "spLauncher.util".workspace("tsserver", function(root_dir)
                                      if vim.fn.filereadable(root_dir .. "/bun.lockb") ~= 0 then
                                        return {
                                          base = "bun run",
                                          run = "start",
                                          debug = true,
                                          test = true,
                                          build = true,
                                        }
                                      elseif vim.fn.filereadable(root_dir .. "/package-lock.json") ~= 0 then
                                        return {
                                          base = "npm run",
                                          run = "start",
                                          debug = true,
                                          test = true,
                                          build = true,
                                        }
                                      end
                                    end, buf)

require "otter".activate { "html", "css" }
