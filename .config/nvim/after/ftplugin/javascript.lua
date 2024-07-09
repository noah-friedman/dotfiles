local buf = vim.api.nvim_get_current_buf()

vim.bo[buf].tabstop = 2
vim.bo[buf].softtabstop = 2
vim.bo[buf].shiftwidth = 2

---@type spLauncher.ActionMap
vim.b[buf].spLauncherActionMap = {
  base = "bun",
  run = "run %",
  test = "test %:p",
}

require "spLauncher.util".workspace("typescript-tools", function(root_dir)
                                      ---@param fname string
                                      local function checkFile(fname)
                                        return vim.fn.filereadable(root_dir .. "/" .. fname) ~= 0
                                      end
                                      local r = {
                                        base = (checkFile "bun.lockb" and "bun run" or (checkFile "package-lock.json" and "npm run" or nil)),
                                        run = "start",
                                        debug = true,
                                        test = true,
                                        build = true,
                                        clean = true,
                                      }
                                      return r.base and r or {}
                                    end, buf)

require "otter".activate { "html", "css" }
