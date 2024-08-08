---@type spLauncher.ActionMap
vim.b.spLauncherActionMap = {
  base = "clang++",
  run = function()
    local temp = vim.fn.tempname()
    return "-o " .. temp .. " % && " .. temp
  end,
  debug = {
    handler = function()
      local temp = vim.fn.tempname()
      return "-g -o " .. temp .. " % && lldb " .. temp
    end,
    config = {
      window = {
        focus = "insert",
        persist = false,
      },
    },
  },
  build = "%",
}

---@param root_dir string
require "spLauncher.util".workspace("clangd", function(root_dir)
  if vim.fn.globpath(root_dir, "**/CMakeLists.txt") ~= "" then
    return {
      base = "cmake",
      ---@return string
      build = function()
        return "-S " .. vim.fn.getcwd() .. " -B " .. vim.fn.getcwd() .. "/build"
      end
    }
  end
  return {}
end)
