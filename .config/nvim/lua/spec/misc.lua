return {
  {
    "darfink/vim-plist",
    event = { "BufReadPre *.plist", "BufNewFile *.plist" },
    config = function()
      vim.schedule_wrap(vim.cmd.e)()
    end,
  },
}
