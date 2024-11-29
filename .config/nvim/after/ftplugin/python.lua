---@return string
local function base()
  return require "venv-selector".python() or "python3"
end


---@type spLauncher.ActionMap
vim.b.spLauncherActionMap = {
  run = function()
    return base() .. " %"
  end,
  debug = {
    handler = function()
      return base() .. " -m pdb %"
    end,
    config = {
      window = {
        focus = "insert",
        persist = false,
      }
    }
  },
  test = "-m unittest %",
}
