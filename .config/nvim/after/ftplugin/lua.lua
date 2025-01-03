vim.bo.shiftwidth = 2
vim.bo.tabstop = 2

vim.b.spLauncherActionMap = {
  run = "lua %",
  debug = function()
    vim.cmd "luafile %"
  end
}
