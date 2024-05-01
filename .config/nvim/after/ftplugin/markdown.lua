vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

vim.b.spLauncherActionMap = {
  run = function() vim.cmd.MarkdownPreview() end,
}
