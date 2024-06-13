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
                                      base = "cargo cmd",
                                      run = true,
                                      debug = true,
                                      build = true,
                                      test = true,
                                      clean = true,
                                    }, buf)
