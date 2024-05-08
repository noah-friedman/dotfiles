---@type spLauncher.ActionMap
vim.b.spLauncherActionMap = {
  run = "java %",
  build = "javac %",
  clean = {
    handler = function()
      return "rm " .. vim.fn.expand "%:p:h" .. "/*.class"
    end,
    config = {
      notify = true,
      silent = true,
    }
  }
}
