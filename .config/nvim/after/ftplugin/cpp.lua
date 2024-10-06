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
      base = "cmake -S . -B ./build",
      run = function()
        local fname = vim.fn.expand "%:t:r"
        return "&& cmake --build ./build && [ -f './build/" .. fname .. "' ] && ./build/" .. fname
      end,
      debug = function()
        local fname = vim.fn.expand "%:t:r"
        return "&& cmake --build ./build && [ -f './build/" .. fname .. "' ] && lldb ./build/" .. fname
      end,
      build = "",
    }
  end
  return {}
end)
