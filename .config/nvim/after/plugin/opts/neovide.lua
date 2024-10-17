if vim.g.neovide then
  if vim.fn.getcwd() == "/" then
    vim.cmd.cd(vim.env.HOME)
  end

  vim.g.neovide_cursor_smooth_blink = true
  vim.o.guifont = "Monocraft Nerd Font,Monocraft"
  vim.o.winblend = 15
  vim.o.pumblend = 10
  vim.o.guicursor = ("n-v:block,i-c-ci-ve:ver20,r-cr:hor20,o:hor50,a:blinkwait175-blinkoff500-blinkon500-Cursor/lCursor"
    .. ",sm:block-blinkwait175-blinkoff500-blinkon500")
end
