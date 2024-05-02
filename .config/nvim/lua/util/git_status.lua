return function()
  if not pcall(vim.cmd.Telescope, "git_status") then
    vim.cmd.Git "status"
  end
end
