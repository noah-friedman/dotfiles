---@type spLauncher.ActionMap
vim.b.spLauncherActionMap = {
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
