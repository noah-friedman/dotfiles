local buf = vim.api.nvim_get_current_buf()

---@type spLauncher.ActionMap
vim.b[buf].spLauncherActionMap = {
  base = "rustc",
  run = function()
    local temp = vim.fn.tempname()
    return "-o " .. temp .. " % && " .. temp
  end,
  debug = {
    handler = function()
      local temp = vim.fn.tempname()
      return "-g -o " .. temp .. " % && rust-lldb " .. temp
    end,
    config = {
      window = {
        focus = "insert",
        persist = false,
      },
    },
  },
  test = function()
    local temp = vim.fn.tempname()
    return "--test -o " .. temp .. " % && " .. temp
  end,
  build = "%",
}

require "spLauncher.util".workspace("rust-analyzer", {
                                      base = "cargo",
                                      run = true,
                                      debug = {
                                        handler = function()
                                          local output = vim.fn.system("(cd " .. vim.fn.expand "%:p:h" ..
                                            " && cargo read-manifest)")
                                          local success, result = pcall(vim.json.decode, output)
                                          if not (success and result and result.name) then
                                            vim.notify(
                                              "failed to read cargo manifest: " .. result .. "\n`cargo read-manifest`" ..
                                              " output:\n" .. output, vim.log.levels.ERROR)
                                            return
                                          end
                                          return "build && rust-lldb target/debug/" .. result.name
                                        end
                                      },
                                      build = true,
                                    }, buf)
