---@type spLauncher.ActionMap
vim.b.spLauncherActionMap = {
  base = "cmake",
  run = function()
    local dir = vim.fn.expand "%:p:h"
    return "-S " .. dir .. " -B " .. dir .. "/build && cmake --build " .. dir .. "/build"
  end,
  build = function()
    local dir = vim.fn.expand "%:p:h"
    return "-S " .. dir .. " -B " .. dir .. "/build"
  end
}
