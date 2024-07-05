vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.textwidth = 115

vim.b.spLauncherActionMap = {
  run = function() vim.cmd.MarkdownPreview() end,
}
