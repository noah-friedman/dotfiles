return {
  {
    "fladson/vim-kitty",
    ft = "kitty"
  },
  {
    "darfink/vim-plist",
    event = { "BufReadPre *.plist", "BufNewFile *.plist" },
    config = function()
      vim.schedule_wrap(vim.cmd.e)()
    end,
  },
  {
    "aldafu/vim-widl",
    event = { "BufReadPre *.webidl", "BufNewFile *.webidl" },
  },
}
